import Foundation
import Algorithms

enum Error: Swift.Error {
    case invalidData
}

enum Identation: String {
    case fourSpaces = "    "
    case twoSpaces = "  "
}

/// A representation of a type
/// This is a struct that reptresents a struct
/// For example:
/// struct A {
///    let a: Bool
/// }
struct CodableType: Equatable, Hashable {
    
    /// A representation of a property of a type
    struct Property: Equatable, Hashable {
        var letOrVar = "let"
        var symbol = "symbol"
        var typeName = "Any"
        var isOptional = false
        var relatedType: CodableType?
    }
    
    /// Whether you are building struct or class
    let structOrClass = "struct"
    
    /// The name of the type
    let name: String
    
    /// An array of the properties in the type
    let properties: [Property]
    
    /// Unique sub-types in the type
    var uniqueTypes: [[Property]: CodableType] {
        var uniqueTypes = [[Property]: CodableType]()
        
        func fillUniqueTypes(root: CodableType, uniqueTypes: inout [[Property]: CodableType]) {
            uniqueTypes[root.properties] = root
            root.properties.forEach { property in
                if let relatedType = property.relatedType {
                    fillUniqueTypes(root: relatedType, uniqueTypes: &uniqueTypes)
                }
            }
        }
        
        fillUniqueTypes(root: self, uniqueTypes: &uniqueTypes)
        return uniqueTypes
    }
    
    /// All the structs to be printed
    var structs: [String] {
        let structs = uniqueTypes
            .map { (pair) -> String in
                let (_, codableType) = pair
                
                var implementation = [String]()
                implementation += ["\(codableType.structOrClass) \(codableType.name.asType): Codable {"]
                
                // create – let <symbol>: <type><optional-syntactic-suggar>
                
                let properties = codableType.properties
                    .map { (property) -> String in
                        // get the name from the uniquetype list.
                        let typeName: String
                        if let relatedType = property.relatedType {
                            typeName = uniqueTypes[relatedType.properties]?.name ?? property.typeName
                        } else {
                            typeName = property.typeName
                        }
                        
                        let optionalSintacticSuggar = property.isOptional ? "?": ""
                        return "\(property.letOrVar) \(property.symbol.asSymbol): \(typeName.asType)\(optionalSintacticSuggar)"
                    }
                    .sorted()
                    .reduce([String]()) { partialResult, line in
                        return partialResult + [line.idented]
                    }
                
                implementation += properties
                
                // create coding keys
                var codingKeys: [String] = ["enum CodingKeys: String, CodingKey {".idented]
                
                let cases = codableType.properties
                    .map { property in
                        "case \(property.symbol.asSymbol) = \"\(property.symbol)\""
                    }
                    .sorted()
                    .reduce([String]()) { partialResult, line in
                        return partialResult + [line.idented.idented]
                    }
                
                codingKeys += cases
                codingKeys += ["}".idented]
                implementation += codingKeys
                implementation += ["}"]
                return implementation.joined(separator: "\n")
            }

        return Array(structs.uniqued().sorted())
    }
    
    var description: String {
        let description = structs.joined(separator: "\n")
        return description
    }
}

// Make this system as anti fragile as possible! The more automated this is the better. I don't want to update any API manually ever again!
extension String {
    
    /// Uppercases the first character
    var asType: String {
        var string = self
        let firstChar = string.removeFirst()
        return firstChar.uppercased() + string
    }
    
    /// Lowercases the first Character
    var asSymbol: String {
        var string = self
        let firstChar = string.removeFirst()
        return firstChar.lowercased() + string
    }
    
    /// Idented string
    var idented: String {
        Identation.fourSpaces.rawValue + self
    }
    
    enum SwiftOrCodableType: Hashable, Equatable {
        case swiftType(String)
        case codableType(CodableType)
        
        /// Returns Swift Type or Codable type
        /// - Parameter jsonObject: Any object that
        /// - Returns: Either a swiftType or a Codable Type
        static func swiftOrCodableType(for jsonObject: Any) throws -> SwiftOrCodableType? {
            var swiftOrCodableType: SwiftOrCodableType?
            
            // check what type is each element of the array
            switch jsonObject {
            case let dictionary as [String: Any]: // for dictionaries
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let string = String(data: data, encoding: .utf8)!
                let codableType = try string.codableType(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON")
                swiftOrCodableType = .codableType(codableType)
            case _ as String:
                swiftOrCodableType = .swiftType("String")
            case _ as Bool:
                swiftOrCodableType = .swiftType("Bool")
            case _ as Decimal:
                swiftOrCodableType = .swiftType("Decimal")
            case _ as Double:
                swiftOrCodableType = .swiftType("Double")
            case _ as Int:
                swiftOrCodableType = .swiftType("Int")
                //        case _ as [Any]:
                //            swiftOrCodableType = .swiftType("[Any]") // TODO: Remove [Any] if possible
            default:
                assertionFailure() // unhandled case
            }
            return swiftOrCodableType
        }
    }
    
    /// Get the name of the Array type.
    /// - Parameters:
    ///   - anyArray: The array of json objects.
    ///   - key: The key of the array. This is used to infer the name of the Array type.
    /// - Returns: Array type name.
    func arrayTypeName(
        anyArray: [Any],
        key: String
    ) throws -> String {
        let arrayOfSwiftOrCodableTypes = try anyArray.compactMap(SwiftOrCodableType.swiftOrCodableType(for:))
        let swiftOrCodableTypes = Set<SwiftOrCodableType>(arrayOfSwiftOrCodableTypes)
        
        // write the type
        var swiftCode = ""
        
        if swiftOrCodableTypes.count == 0 {
            swiftCode += "[Any]"
        } else if swiftOrCodableTypes.count == 1 {
            var typeName = ""
            switch swiftOrCodableTypes.first! {
            case .swiftType(let name):
                typeName = name
            case .codableType(_):
                typeName = key.asType
            }
            swiftCode += "[\(typeName)]"
        } else if swiftOrCodableTypes.count > 1 {
            
            let containsNames = swiftOrCodableTypes.contains { nameOrCodatbleType in
                switch nameOrCodatbleType {
                case .swiftType(_):
                    return true
                case .codableType(_):
                    return false
                }
            }
            
            let containsImplementations = swiftOrCodableTypes.contains { nameOrCodableType in
                switch nameOrCodableType {
                case .swiftType(_):
                    return false
                case .codableType(_):
                    return true
                }
            }
            
            if !containsNames && !containsImplementations {
                assertionFailure("This case is not possible")
            }
            if containsNames && !containsImplementations {
                swiftCode += "[Any]" // TODO: Remove [Any] if possible
            }
            if !containsNames && containsImplementations {
                swiftCode += "[\(key.asType)]"
            }
            if containsNames && containsImplementations {
                swiftCode += "[Any]" // TODO: Remove [Any] if possible
            }
        }
        return swiftCode
    }
    
    /// Returns a Optional Codable type
    /// - Parameters:
    ///   - anyArray: Array of JSON Objects
    ///   - key: Key for the codable type
    /// - Returns: An optional codable type for the JSON objects
    func codableType(
        anyArray: [Any],
        key: String
    ) throws -> CodableType? {
        let arrayOfSwiftOrCodableTypes = try anyArray.compactMap(SwiftOrCodableType.swiftOrCodableType(for:))
        let swiftOrCodableTypes = Set<SwiftOrCodableType>(arrayOfSwiftOrCodableTypes)
        
        let codableTypes = swiftOrCodableTypes
            .compactMap { (nameOrCodableTypes) -> CodableType? in
                switch nameOrCodableTypes {
                case .swiftType(_):
                    return nil
                case .codableType(let codableType):
                    return codableType
                }
            }
        
        guard !codableTypes.isEmpty else {
            return nil
        }
        let properties = codableTypes.map { $0.properties }
        let allProperties = properties.flatMap { $0 }
        var propertyCount = [CodableType.Property: Int]()
        allProperties.forEach { property in
            propertyCount[property] = propertyCount[property, default: 0] + 1
        }
        let propertiesWithOptionalSupport = propertyCount.map { (key: CodableType.Property, value: Int) -> CodableType.Property in
                .init(
                    letOrVar: key.letOrVar,
                    symbol: key.symbol,
                    typeName: key.typeName,
                    isOptional: value != codableTypes.count,
                    relatedType: key.relatedType
                )
        }
        return .init(name: key.asType, properties: propertiesWithOptionalSupport)
    }
    
    /// Compiles a valid JSON to a Codable Swift Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: JSON errors or errors in the library.
    /// - Returns: The string of the type produced by the JSON
    func codableType(name: String) throws -> CodableType {
        guard let data = data(using: .utf8) else {
            throw Error.invalidData
        }        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw Error.invalidData
        }
        let properties = try dictionary
            .sorted(by: { $0.0 < $1.0 })
            .map { (pair) -> CodableType.Property in
                let (key, value) = pair
                
                var typeName = "Any"
                var relatedType: CodableType?
                
                switch value {
                case _ as Bool:
                    typeName = "Bool"
                case _ as String:
                    typeName = "String"
                case _ as Decimal:
                    typeName = "Decimal"
                case _ as Double:
                    typeName = "Double"
                case _ as Int:
                    typeName = "Int"
                case let jsonObject as [String: Any]:
                    let objectData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                    let objectString = String(data: objectData, encoding: .utf8)!
                    let codableType = try objectString.codableType(name: key)
                    typeName = codableType.name
                    relatedType = codableType
                case let anyArray as [Any]:
                    if let codableType = try codableType(anyArray: anyArray, key: key) {
                        typeName = codableType.name
                        relatedType = codableType
                    }
                    else {
                        typeName = try arrayTypeName(anyArray: anyArray, key: key)
                    }
                default:
                    // TODO: Add more cases like dates
                    break
                }
                return .init(symbol: key, typeName: typeName, isOptional: false, relatedType: relatedType)
                
            }
        return .init(name: name, properties: properties)
    }
    
    /// Get the Codable code from the provided JSON
    /// - Parameter name: The name of the struct, if no struct is provided you'll get a placeholder of the type <#SomeType#>
    /// - Returns: The codable code as a string.
    public func codableCode(name: String = "<#SomeType#>") throws -> String {
        return try codableType(name: name).description
    }
}
