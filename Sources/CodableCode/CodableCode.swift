import Foundation
import Algorithms
import Collections

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
    
    func printEscaping() {
        let lines = split(separator: "\n")
        lines.forEach { line in
            print(line)
        }
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
    
    func makeArrayType(
        anyArray: [Any],
        key: String,
        margin: String,
        preference: Preference
    ) throws -> String {
        var typesInArray = Set<String>()
        var typeImplementations = OrderedSet<String>()
        var optionTypeImplementations = OrderedSet<String>()
        
        // first we assume we have an array of Any
        try anyArray.forEach { jsonObject in //then to confirm or deny that we traverse array to get a list of the different types
            
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
            case let dictionary as [String: Any]: // for dictionaries
                let objectData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let objectString = String(data: objectData, encoding: .utf8)!
                let hashableTypeImplementation = try objectString.codableCode(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON", margin: "") // create the type implementation
                if !typeImplementations.contains(hashableTypeImplementation) { // if the existing type implementations does not contain the dummy type implementation
                    typeImplementations.append(hashableTypeImplementation) // add it to the list of unique types
                    if typeImplementations.count == 1 {
                        type = key.asType
                    } else {
                        type = key.asType + "\(typeImplementations.count)" // keep a count for naming the different types
                    }
                    let optionTypeImplementation = try objectString.codableCode(name: type!, margin: margin + identation) // make the actual implementation with it's given name
                    optionTypeImplementations.append(optionTypeImplementation) // insert it to the optionTypeImplementations array
                }
            default:
                type = ""
                assertionFailure() // unhandled case
            }
            if let unwrappedType = type {
                typesInArray.insert(unwrappedType) // append the type to the list
            }
        }
        
        // write the type
        var swiftCode = ""
        switch (typesInArray.count, preference) {
        case (0, _):
            swiftCode += "[Any]"
        case (1, _):
            swiftCode += "[\(key.asType)]"
        case (_, .enumWithAssociatedTypes):
            swiftCode += "[\(key.asType)Options]"
        case (_, .optionalsWhereRequired):
            swiftCode += "[\(key.asType)]"
        }
        swiftCode.lineBreak()
        return swiftCode
    }
    
    func makeTypeImplementations(
        anyArray: [Any],
        key: String,
        margin: String,
        preference: Preference
    ) throws -> String {
        return "<struct implementation work in progress>"
    }
    
    func makeArrayTypeAndImplementations(
        anyArray: [Any],
        key: String,
        margin: String,
        preference: Preference = .optionalsWhereRequired
    ) throws -> String {
        var swiftCode = ""
        swiftCode += try makeArrayType(anyArray: anyArray, key: key, margin: margin, preference: preference)
        swiftCode += try makeTypeImplementations(anyArray: anyArray, key: key, margin: margin, preference: preference)
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
                    swiftCode += try makeArrayTypeAndImplementations(anyArray: anyArray, key: key, margin: margin)
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
