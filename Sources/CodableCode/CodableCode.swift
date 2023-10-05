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
        var relatedType: TypeOption?
    }
    
    /// Whether you are building struct or class
    let structOrClass = "struct"
    
    /// The name of the type
    let name: String
    
    /// An array of the properties in the type
    let properties: [Property]
    
    /// Unique sub-types in the type
    var uniqueTypes: [[Property]: TypeOption] {
        var uniqueTypes = [[Property]: TypeOption]()
        
        func fillUniqueTypes(root: TypeOption, uniqueTypes: inout [[Property]: TypeOption]) {
            switch root {
            case .swiftType(_):
                fatalError()
                break
            case let .productType(productType):
                uniqueTypes[productType.properties] = .productType(productType)
                productType.properties.forEach { property in
                    if let relatedType = property.relatedType {
                        fillUniqueTypes(root: relatedType, uniqueTypes: &uniqueTypes)
                    }
                }
            case .sumType(_):
                break
            case let .arrayType(_):
                break
            case let .anyType(_):
                break
            }
        }
        
        fillUniqueTypes(root: .productType(self), uniqueTypes: &uniqueTypes)
        return uniqueTypes
    }
    
    /// Lines of code of all the structs to be printed.
    var structs: [String] {
        let structs = uniqueTypes
            .map { (pair) -> String in
                let (_, codableType) = pair
                
                guard case let .productType(productType) = codableType else {
                    fatalError()
                }
                
                var implementation = [String]()
                implementation += ["\(productType.structOrClass) \(productType.name.asType): Codable {"]
                
                // create – let <symbol>: <type><optional-syntactic-suggar>
                
                guard case let .productType(productType) = codableType else {
                    fatalError()
                }
                
                let properties = productType.properties
                    .map { (property) -> String in
                        // get the name from the uniquetype list.
                        let typeName: String
                        if case let .productType(relatedProductType) = property.relatedType,
                           case let .productType(relatedProductType2) = uniqueTypes[relatedProductType.properties] {
                            typeName = relatedProductType2.name
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
                
                let cases = productType.properties
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
    
    init(name: String, properties: [Property]) {
        self.name = name
        self.properties = properties
    }
    
    static func productType(name: String, dictionary: [String: Any]) throws -> ProductType {
        let properties = try dictionary
            .sorted(by: { $0.0 < $1.0 })
            .map { (pair) -> ProductType.Property in
                let (key, value) = pair
                var name = "Any"
                var relatedType: TypeOption?
                switch value {
                case _ as Bool:
                    name = SwiftType.Bool.rawValue
                case _ as String:
                    name = SwiftType.String.rawValue
                case _ as Decimal:
                    name = SwiftType.Decimal.rawValue
                case _ as Double:
                    name = SwiftType.Double.rawValue
                case _ as Int:
                    name = SwiftType.Int.rawValue
                case let jsonObject as [String: Any]:
                    let productType = try ProductType.productType(
                        name: key,
                        dictionary: jsonObject
                    )
                    name = productType.name
                    relatedType = .productType(productType)
                case let jsonObjects as [Any]:
                    let arrayType = try ArrayType(
                        jsonObjects: jsonObjects,
                        name: key
                    )
                    name = arrayType.typeName
                    relatedType = .arrayType(arrayType)
                default:
                    // TODO: Add more cases 
                    // like dates
                    // <null>
                    // fatalError()
                    break
                }
                return .init(symbol: key, typeName: name, isOptional: false, relatedType: relatedType)
            }
        return .init(name: name, properties: properties)
    }
    
    /// Infers a product type from the array of json objects
    /// - Parameters:
    ///   - anyArray: Array of JSON Objects
    ///   - key: Key for the codable type
    /// - Returns: An optional codable type for the JSON objects
    init?(jsonObjects: [Any], key: String) throws {
        let arrayOfTypes = try jsonObjects.compactMap { try TypeOption.type(for: $0) }
        let setOfTypes = Set<TypeOption>(arrayOfTypes)
        let productTypes = setOfTypes
            .compactMap { (type) -> ProductType? in
                switch type {
                case .swiftType(_):
                    return nil
                case .productType(let productType):
                    return productType
                case .sumType(_):
                    return nil
                case .arrayType(_):
                    return nil
                case .anyType(_):
                    return nil
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
        self.name = key.asType
        self.properties = propertiesWithOptionalSupport
    }
}

indirect enum TypeOption: Hashable, Equatable {
    case swiftType(SwiftType)
    case productType(ProductType)
    case sumType(SumType)
    case arrayType(ArrayType)
    case anyType(AnyType)
    
    var name: String {
        switch self {
            
        case let .swiftType(swiftType):
            return swiftType.rawValue
        case let .productType(productType):
            return productType.name
        case let .sumType(sumType):
            return sumType.name
        case let .arrayType(arrayType):
            return arrayType.typeName
        case let .anyType(anyType):
            return anyType.name
        }
    }
    
    /// Returns Swift Type or Codable type
    /// - Parameter jsonObject: Any object that
    /// - Returns: Either a swiftType or a Codable Type
    static func type(for jsonObject: Any) throws -> TypeOption? {
        var typeOption: TypeOption?
        switch jsonObject {
        case _ as String:
            typeOption = .swiftType(.String)
        case _ as Bool:
            typeOption = .swiftType(.Bool)
        case _ as Decimal:
            typeOption = .swiftType(.Decimal)
        case _ as Double:
            typeOption = .swiftType(.Double)
        case _ as Int:
            typeOption = .swiftType(.Int)
        case let dictionary as [String: Any]:
            let productType = try ProductType.productType(
                name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON",
                dictionary: dictionary
            )
            typeOption = .productType(productType)
        case let jsonObjects as [Any]:
            let arrayType = try ArrayType(
                jsonObjects: jsonObjects,
                name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON"
            )
            typeOption = .arrayType(arrayType)
        default:
            assertionFailure()
        }
        return typeOption
    }
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
    let name: String
    
    init(typeOptions: [TypeOption], name: String) {
        self.name = name
    }
}

struct ArrayType: Equatable, Hashable {
    var typeName: String {
        return "[\(relatedType.name)]"
    }
    
    let relatedType: TypeOption
    
    enum UseOptionalsOrEnums {
        case optionals // When an item is on an array element and is not in the next treats it as an optional
        case enums // When an item is on an array element and is not in the next treats it as an enum
    }
    
    init(jsonObjects: [Any], name: String, config: UseOptionalsOrEnums = .enums) throws {
        var typeOptions = [TypeOption]()
        for jsonObject in jsonObjects {
            guard let typeOption = try TypeOption.type(for: jsonObject) else {
                fatalError()
            }
            typeOptions.append(typeOption)
        }
        switch config {
        case .optionals:
            self.relatedType = .sumType(.init(typeOptions: [], name: "NotSupported"))
            fatalError()
        case .enums:
            self.relatedType = .sumType(.init(typeOptions: typeOptions, name: name))
            print("name: \(name)")
        }
    }
}

struct AnyType: Equatable, Hashable {
    let name = "Any"
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
    
    /// Compiles a valid JSON to a Codable Swift Product Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: JSON errors or errors in the library.
    /// - Returns: The string of the type produced by the JSON
    func dictionary() throws -> [String: Any] {
        guard let data = data(using: .utf8) else {
            throw Error.invalidData
        }        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw Error.unsupportedArrayAtRootLevel
        }
        return dictionary
    }
    
    /// Get the Codable code from the provided JSON
    /// - Parameter name: The name of the struct, if no struct is provided you'll get a placeholder of the type <#SomeType#>
    /// - Returns: The codable code as a string.
    public func codableCode(name: String = "<#SomeType#>") throws -> String {
        let dictionary = try dictionary()
        let productType = try ProductType.productType(name: name, dictionary: dictionary)
        return productType.description
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
