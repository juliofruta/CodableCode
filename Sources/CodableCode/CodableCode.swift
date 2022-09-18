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
                let typeImplementation = try objectString.codableCode(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON", margin: "") // used to see if it's in the set of options already
                
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
        
        // write the type and then all the needed implementations
        
        var swiftCode = ""
        
        if typesInArray.isEmpty { // if it's empty then anything could come in there.
            swiftCode += "[Any]"
        } else if typesInArray.count == 1 { // if it's only one then we assume that there can only be elements of this type.
            swiftCode += "[\(typesInArray.first!)]"
        } else { // if there's more than one we have two options...
            switch preference {
            case .enumWithAssociatedTypes: // either use sum the types
                swiftCode += "\(key.asType)Options" // write that the type is the enum
                swiftCode.lineBreak()
                swiftCode.lineBreak()
                swiftCode += margin + identation + "enum \(key.asType)Options: Codable {" // create enum with associated types
                let options = typesInArray // rename types to options
                options.forEach { option in
                    swiftCode.lineBreak()
                    swiftCode += margin + identation + identation + "case \(option.asSymbol)(\(option))" // add associated types to the enum
                }
                swiftCode.lineBreak()
                swiftCode += margin + identation + "}"
                optionTypeImplementations.forEach { implementation in // for each implementation write the implementation of the different options
                    swiftCode.lineBreak()
                    swiftCode.lineBreak()
                    swiftCode += implementation
                    swiftCode.lineBreak()
                }
                
            case .optionalsWhereRequired: // diff the types and check for what's optional
                swiftCode += "[\(key.asType)]" // add the key as the type
                swiftCode.lineBreak()
                
                // and then write the implementation
                
                // diff the types
                // get the lines that dissappear or appear
                // filter the lines that have let <symbol>: <type>
                // get the :<type> that dissapear by diffing
                // build type
                                
                var changes = Set<String>()
                uniqueTypes
                    .map { $0.components(separatedBy: "\n") } // separate by lines and get array of arrays
                    .map {
                        $0.filter { $0.hasPrefix(margin + identation + "let") } // get only the lines that have let
                    }
                    .combinations(ofCount: 2)
                    .forEach { pair in
                        let lhs = Array(pair[0])
                        let rhs = Array(pair[1])
                        
                        if #available(macOS 10.15, *) { // mac os check. I hate this... want to avoid it.
                            
                            // getting a diff for each case
                            let diff = lhs.difference(from: rhs)
                            
                            let printDiffingInfo = false
                            if printDiffingInfo {
                                print("lhs")
                                lhs.forEach { print("\($0)") }
                                print("rhs")
                                rhs.forEach { print("\($0)") }
                                diff.removals.map { "- \($0)" }.forEach { print($0) }
                                diff.insertions.map { "+ \($0)" }.forEach { print($0) }
                            }
        
                            // add changes to the changes set
                            diff.removals.forEach {
                                switch $0 {
                                case .insert(offset: _, element: let element, associatedWith: _):
                                    changes.insert(element)
                                case .remove(offset: _, element: let element, associatedWith: _):
                                    changes.insert(element)
                                }
                            }
                            diff.insertions.forEach {
                                switch $0 {
                                case .insert(offset: _, element: let element, associatedWith: _):
                                    changes.insert(element)
                                case .remove(offset: _, element: let element, associatedWith: _):
                                    changes.insert(element)
                                }
                            }
                        } else {
                            fatalError()
                        }
                    }
                
                
                let aTypeImplementation = uniqueTypes.first! // para empezar aqui vamos mal... por que unique types quien sabe que type tenga.
                // unique types podria tener implementaciones que nada que ver una con la otra y algunas podrian tener implementaciones de estructuras y otras no.
                // algunas estructuras podrian estar repetidas en nombre y con diferente implementacion. ¿Como resolver este problema?
                
                var lines = aTypeImplementation.split(separator: "\n").map { String.init($0) }
                
                changes
                    .sorted()
                    .forEach { change in
                        var lineChanged = change
                        lines.removeAll(where: { $0 == change }) // remove repeated lines
                        lineChanged += "?" // add sintactic suggar "?"
                        lines.insert(lineChanged, at: lines.count - 1)
                    }
                
                // write code
                lines.removeFirst() // to remove the MOCKED_TYPE message
                lines.insert(margin + "struct \(key.asType): Codable {", at: 0)
                let structImplementation = lines
                    .map { margin + identation + $0 }
                    .joined(separator: "\n")
                
                swiftCode += structImplementation
                
                // BUG: lol I'm missing the complete C2 implementation by filtering and rewriting the struct.
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
