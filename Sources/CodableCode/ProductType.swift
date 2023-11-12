import Foundation

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
    
    /// Self and unique sub-types used in the struct
    var memoizedTypes: MemoizedTypes {
        var types = MemoizedTypes()
        add(.productType(self), to: &types)
        return types
    }
    
    static func implementation(productType: ProductType, memoizedTypes: inout MemoizedTypes) -> [String] {
        var implementation = [String]()
        implementation += ["\(productType.structOrClass) \(productType.name.asType): Codable {"]
        
        // create – let <symbol>: <type><optional-syntactic-suggar>
        let properties = productType.properties
            .map { (property) -> String in
                // get the name from the uniquetype list.
                let typeName: String
                if case let .productType(relatedProductType) = property.relatedType,
                   case let .productType(relatedProductType2) = memoizedTypes[.structKey(relatedProductType.properties)] {
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
        
        // if needed
        if !productType.properties.isEmpty {
            // create coding keys enum
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
        }
        
        implementation += ["}"]
        return implementation
    }
    
    /// Lines of code of all the structs to be printed.
    func linesOfCode(memoizedTypes: inout MemoizedTypes) -> [String] {
        let structs = memoizedTypes
            .allTypes
            .map { (typeOption) -> String in
                switch typeOption {
                case .swiftType(_):
                    fatalError()
                    break
                case let .productType(productType):
                    return ProductType
                        .implementation(productType: productType, memoizedTypes: &memoizedTypes)
                        .joined(separator: "\n")
                case let .sumType(sumType):
                    return SumType
                        .implementation(sumType: sumType, memoizedTypes: &memoizedTypes)
                        .joined(separator: "\n")
                case .arrayType(_):
                    fatalError()
                    break
                case .anyType(_):
                    fatalError()
                    break
                }
            }
        let linesOfCode = structs
            .uniqued() // We don't want to repeat code
            .sorted()  // We want to sort the types alphabetically
        return linesOfCode
    }
    
    func code(memoizedTypes: inout MemoizedTypes) -> String {
        let code = linesOfCode(memoizedTypes: &memoizedTypes).joined(separator: "\n")
        return code
    }
    
    private init(name: String, properties: [Property]) {
        self.name = name
        self.properties = properties
    }
    
    static func productType(name: String, dictionary: [String: Any], memoizedTypes: inout MemoizedTypes) throws -> ProductType {
        let properties = try dictionary
            .sorted(by: { $0.0 < $1.0 })
            .map { (pair) -> ProductType.Property in
                let (key, value) = pair
                let name: String
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
                        dictionary: jsonObject,
                        memoizedTypes: &memoizedTypes
                    )
                    name = productType.name
                    relatedType = .productType(productType)
                case let jsonObjects as [Any]:
                    let arrayType = try ArrayType(
                        jsonObjects: jsonObjects,
                        name: key.asType,
                        memoizedTypes: &memoizedTypes
                    )
                    name = arrayType.name
                    relatedType = .arrayType(arrayType)
                default:
                    // TODO: Add more cases
                    // like dates
                    // <null>
                    name = AnyType().name
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
    init?(jsonObjects: [Any], key: String, memoizedTypes: inout MemoizedTypes) throws {
        let arrayOfTypes = try jsonObjects.compactMap { try TypeOption.type(for: $0, memoizedTypes: &memoizedTypes) }
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
