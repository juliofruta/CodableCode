import Foundation
import Algorithms

enum Error: Swift.Error {
    case invalidData
    case unsupportedArrayAtRootLevel
}

enum Identation: String {
    case fourSpaces = "    "
    case twoSpaces = "  "
}

/// A representation of a product type
/// This is a struct that reptresents a product type, which can be either a class, struct or actor.
/// For example:
/// struct A {
///    let a: Bool
///    CodingKeys {
///        case a = "a"
///    }
/// }
struct ProductType: Equatable, Hashable {
    
    /// A representation of a property of a type
    struct Property: Equatable, Hashable {
        var letOrVar = "let"
        var symbol = "symbol" // Sentinel value
        var typeName = "Any" // Sentinel vlaue
        var isOptional = false
        var relatedType: ProductType?
    }
    
    /// Whether you are building struct or class
    let structOrClass = "struct"
    
    /// The name of the type
    let name: String
    
    /// An array of the properties in the type
    let properties: [Property]
    
    /// Unique sub-types in the type
    var uniqueTypes: [[Property]: ProductType] {
        var uniqueTypes = [[Property]: ProductType]()
        
        func fillUniqueTypes(root: ProductType, uniqueTypes: inout [[Property]: ProductType]) {
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
    
    /// Swift types as strings.
    enum SwiftType: String {
        case String = "String"
        case Bool = "Bool"
        case Decimal = "Decimal"
        case Double = "Double"
        case Int = "Int"
    }
    
    struct SumType: Equatable, Hashable {
        let string = "enum Tipo {"
    }
    
    enum TypeOption: Hashable, Equatable {
        case swiftType(SwiftType)
        case productType(ProductType)
//        case sumType(SumType) // TODO: Add support for enums.
        
        /// Returns Swift Type or Codable type
        /// - Parameter jsonObject: Any object that
        /// - Returns: Either a swiftType or a Codable Type
        static func type(for jsonObject: Any) throws -> TypeOption? {
            var swiftOrCodableType: TypeOption?
            
            // check what type is the JSON object
            switch jsonObject {
            case _ as String:
                swiftOrCodableType = .swiftType(.String)
            case _ as Bool:
                swiftOrCodableType = .swiftType(.Bool)
            case _ as Decimal:
                swiftOrCodableType = .swiftType(.Decimal)
            case _ as Double:
                swiftOrCodableType = .swiftType(.Double)
            case _ as Int:
                swiftOrCodableType = .swiftType(.Int)
            case let dictionary as [String: Any]: // for dictionaries
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let string = String(data: data, encoding: .utf8)!
                let codableType = try string.productType(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON")
                swiftOrCodableType = .productType(codableType)
//            case let arrayOfAny as [Any]:
//                arrayOfAny.count
//            case _ as [Any]:
//                swiftOrCodableType = .swiftType() // TODO: Remove [Any] if possible
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
        jsonObjects: [Any],
        key: String
    ) throws -> String {
        let arrayOfSwiftOrCodableTypes = try jsonObjects.compactMap(TypeOption.type(for:))
        let swiftOrCodableTypes = Set<TypeOption>(arrayOfSwiftOrCodableTypes)
        
        // write the type
        var swiftCode = ""
        
        if swiftOrCodableTypes.count == 0 {
            swiftCode += "[Any]"
        } else if swiftOrCodableTypes.count == 1 {
            var typeName = ""
            switch swiftOrCodableTypes.first! {
            case .swiftType(let swiftType):
                typeName = swiftType.rawValue
            case .productType(_):
                typeName = key.asType
            }
            swiftCode += "[\(typeName)]"
        } else if swiftOrCodableTypes.count > 1 {
            
            let containsNames = swiftOrCodableTypes.contains { nameOrCodatbleType in
                switch nameOrCodatbleType {
                case .swiftType(_):
                    return true
                case .productType(_):
                    return false
                }
            }
            
            let containsImplementations = swiftOrCodableTypes.contains { nameOrCodableType in
                switch nameOrCodableType {
                case .swiftType(_):
                    return false
                case .productType(_):
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
    
    /// Infers a product type from the array of json objects
    /// - Parameters:
    ///   - anyArray: Array of JSON Objects
    ///   - key: Key for the codable type
    /// - Returns: An optional codable type for the JSON objects
    func productType(jsonObjects: [Any], key: String) throws -> ProductType? {
        let arrayOfTypes = try jsonObjects.compactMap(TypeOption.type(for:))
        let setOfTypes = Set<TypeOption>(arrayOfTypes)
        let productTypes = setOfTypes
            .compactMap { (nameOrCodableTypes) -> ProductType? in
                switch nameOrCodableTypes {
                case .swiftType(_):
                    return nil
                case .productType(let productType):
                    return productType
                }
            }
        
        guard !productTypes.isEmpty else {
            return nil
        }
        
        let properties = productTypes.map { $0.properties }
        let allProperties = properties.flatMap { $0 }
        
        // Check if we have optionals

        // We are going to keep a property count to see what propery does not repeat
        var propertyCount = [ProductType.Property: Int]()
        
        // for each property increase the count
        allProperties.forEach { property in
            propertyCount[property] = propertyCount[property, default: 0] + 1
        }
        
        let propertiesWithOptionalSupport = propertyCount.map { (key: ProductType.Property, value: Int) -> ProductType.Property in
                .init(
                    letOrVar: key.letOrVar,
                    symbol: key.symbol,
                    typeName: key.typeName,
                    isOptional: value != productTypes.count, // if the item is not in all the product types then is optional.
                    relatedType: key.relatedType
                )
        }
        return .init(name: key.asType, properties: propertiesWithOptionalSupport)
    }
    
    /// Compiles a valid JSON to a Codable Swift Product Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: JSON errors or errors in the library.
    /// - Returns: The string of the type produced by the JSON
    func productType(name: String) throws -> ProductType {
        guard let data = data(using: .utf8) else {
            throw Error.invalidData
        }        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw Error.unsupportedArrayAtRootLevel
        }
        let properties = try dictionary
            .sorted(by: { $0.0 < $1.0 })
            .map { (pair) -> ProductType.Property in
                let (key, value) = pair
                
                var typeName = "Any"
                var relatedType: ProductType?
                
                switch value {
                case _ as Bool:
                    typeName = SwiftType.Bool.rawValue
                case _ as String:
                    typeName = SwiftType.String.rawValue
                case _ as Decimal:
                    typeName = SwiftType.Decimal.rawValue
                case _ as Double:
                    typeName = SwiftType.Double.rawValue
                case _ as Int:
                    typeName = SwiftType.Int.rawValue
                case let jsonObject as [String: Any]:
                    let objectData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                    let objectString = String(data: objectData, encoding: .utf8)!
                    let productType = try objectString.productType(name: key)
                    typeName = productType.name
                    relatedType = productType
                case let jsonObjects as [Any]:
                    // if we could get a codableType and a name
                    // Aqui esto esta raro... que le paso un arreglo y me regresa un product type.
                    if let productType = try productType(jsonObjects: jsonObjects, key: key) {
                        typeName = productType.name
                        relatedType = productType
                    }
                    else {
                        typeName = try arrayTypeName(jsonObjects: jsonObjects, key: key)
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
        return try productType(name: name).description
    }
}

/// Function used for printing.
/// - Parameters:
///   - file: The file at which the function was called from.
///   - line: The line at whic the function was called from.
///   - output: The string to be printed.
func dump(file: String = #file, line: Int = #line, _ output: String) {
    print(">>> \(output) |\t\(file):\(line)")
}
