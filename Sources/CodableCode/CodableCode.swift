import Foundation
import Algorithms

enum Error: Swift.Error {
    case invalidData
}

let identation = "    "

// Make this system as anti fragile as possible! The more automated this is the better. I don't want to update the any API manually ever again!
extension String {
    
    var asType: String {
        var string = self
        let firstChar = string.removeFirst()
        return firstChar.uppercased() + string
    }
    
    var asSymbol: String {
        var string = self
        let firstChar = string.removeFirst()
        return firstChar.lowercased() + string
    }
    
    mutating func lineBreak() {
        self = self + "\n"
    }
    
    // TODO: Instead of enum refactor to use optionals where needed.
    // Build Swift Build package plugin
    // use diffing algorithm to introduce optionals?
    // strategies:
    // create
    // 1. enum withassociated types
    // 2. optionals where needed
    // 3. optionals everywhere
    enum Preference {
        case enumWithAssociatedTypes
        case optionalsWhereRequired // in development...
    }
    
    func makeCodableTypeArray(anyArray: [Any], key: String, margin: String, preference: Preference = .optionalsWhereRequired) throws -> String {
        var typesInArray = Set<String>()
        var uniqueTypes = Set<String>()
        var optionTypeImplementations = Set<String>()
        
        try anyArray.forEach { jsonObject in
            
            var type: String?
            
            // check what type is each element of the array
            switch jsonObject {
            case _ as String:
                type = "String"
            case _ as Bool:
                type = "Bool"
            case _ as Decimal:
                type = "Decimal"
            case _ as Double:
                type = "Double"
            case _ as Int:
                type = "Int"
            case let dictionary as [String: Any]:
                let objectData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let objectString = String(data: objectData, encoding: .utf8)!
                let typeImplementation = try objectString.codableCode(name: "TYPE IMPLEMENTATION USED FOR COMPARISON", margin: "") // used to see if it's in the set of options already
                
                // if the existing type does not contain the dummy type implementation
                if !uniqueTypes.contains(typeImplementation) {
                    // insert it
                    uniqueTypes.insert(typeImplementation)
                    // keep a count
                    if uniqueTypes.count == 1 {
                        type = key.asType
                    } else {
                        type = key.asType + "\(uniqueTypes.count)"
                    }
                    // and get the actual implementation
                    let optionTypeImplementation = try objectString.codableCode(name: type!, margin: margin + identation)
                    optionTypeImplementations.insert(optionTypeImplementation)
                }
            default:
                type = ""
                assertionFailure() // unhandled case
            }
            if let unwrappedType = type {
                typesInArray.insert(unwrappedType)
            }
        }
        
        // write type
        var swiftCode = ""
        
        if typesInArray.isEmpty { // if it's empty then anything could come in there.
            swiftCode += "[Any]"
        } else if typesInArray.count == 1 { // if it's only one then we assume that there can only be elements of this type.
            swiftCode += "[\(typesInArray.first!)]"
        } else { // if there's more...
            switch preference {
            case .enumWithAssociatedTypes:
                // write that the type is the enum
                swiftCode += "\(key.asType)Options"
                swiftCode.lineBreak()
                swiftCode.lineBreak()

                // create enum with associated types
                swiftCode += margin + identation + "enum \(key.asType)Options: Codable {"
                
                // types are options
                let options = typesInArray
                
                options.forEach { option in
                    swiftCode.lineBreak()
                    // enum associatedTypes
                    swiftCode += margin + identation + identation + "case \(option.asSymbol)(\(option))"
                }
                
                swiftCode.lineBreak()
                swiftCode += margin + identation + "}"
                
                // write the implementation of the different options
                optionTypeImplementations.forEach { implementation in
                    swiftCode.lineBreak()
                    swiftCode.lineBreak()
                    swiftCode += implementation
                    swiftCode.lineBreak()
                }
                
            case .optionalsWhereRequired:

                fatalError("optionalsWhereRequired in development. use  enum with associated types instead")
                
                // add the key as the type
                swiftCode += "\(key.asType)"
                
                // and then write the implementation
                
                // diff the types
                // get the lines that dissappear or appear
                // filter the lines that have let <symbol>: <type>
                // get the :<type> that dissapear by diffing
                // build type
//
//                var diff = CollectionDifference<[(Int, String)]>([])
//                var additions = [String]()
//                var removals = [String]()
                
                uniqueTypes
                    .map { $0.components(separatedBy: "\n") } // separate by lines and get array of arrays
                    .combinations(ofCount: 2)
                    .forEach { pair in
                        
                        let lhs = Array(pair[0])
                        let rhs = Array(pair[1])
                        
                        if #available(macOS 10.15, *) {
                            
                            // getting a diff for each case
                            let diff = lhs.difference(from: rhs, by: { _, _ in return true })
                            
                            print("lhs")
                            lhs.forEach { print("\($0)") }
                            print("rhs")
                            rhs.forEach { print("\($0)") }
                            
                            diff.removals.map { "- \($0)" }.forEach { print($0) }
                            diff.insertions.map { "+ \($0)" }.forEach { print($0) }
                            
                            
                            // si veo un let removido. hacerlo opcional? no necesariamente? todavia no termino de pensar este algorithm
                        } else {
                            fatalError()
                        }
                    }
            }
        }
        

        
        return swiftCode
    }
    
    /// Compiles a valid JSON to a Codable Swift Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: Not sure if it should throw right now. We can check if the JSON is valid inside
    /// - Returns: The string of the type produced by the JSON
    public func codableCode(name: String, margin: String = "") throws -> String {
        var swiftCode = ""
        swiftCode += margin + "struct \(name.asType): Codable {"
        guard let data = data(using: .utf8) else {
            throw Error.invalidData
        }        
        if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            try dictionary
                .sorted(by: { $0.0 < $1.0 })
                .forEach { pair in
                let (key, value) = pair
                swiftCode.lineBreak()
                swiftCode += margin + identation + "let \(key.asSymbol): "
                switch value {
                case _ as Bool:
                    swiftCode += "Bool"
                case _ as String:
                    swiftCode += "String"
                case _ as Decimal:
                    swiftCode += "Decimal"
                case _ as Double:
                    swiftCode += "Double"
                case _ as Int:
                    swiftCode += "Int"
                case let jsonObject as [String: Any]:
                    let objectData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                    let objectString = String(data: objectData, encoding: .utf8)!
                    swiftCode += "\(key.asType)"
                    swiftCode.lineBreak()
                    swiftCode.lineBreak()
                    swiftCode += try objectString.codableCode(name: key, margin: margin + identation)
                    swiftCode.lineBreak()
                case let anyArray as [Any]:
                    swiftCode += try makeCodableTypeArray(anyArray: anyArray, key: key, margin: margin)
                // TODO: Add more cases like dates
                default:
                    swiftCode += "Any"
                }
            }
        }
        swiftCode.lineBreak()
        swiftCode += margin + "}"
        return swiftCode
    }
    
    public var codableCode: String? {
        try? codableCode(name: "<#SomeType#>")
    }
}

// features to be added.
// add support to automatically fix when reserved keywords have reserved words for example:
// let return: Return // this does not compile and is part of the bitso api
// so add support for coding keys
//
//            struct Landmark: Codable {
//                var name: String
//                var foundingYear: Int
//                var location: Coordinate
//                var vantagePoints: [Coordinate]
//
//                enum CodingKeys: String, CodingKey {
//                    case name = "return"
//                    case foundingYear = "founding_date"
//
//                    case location
//                    case vantagePoints
//                }
//            }
