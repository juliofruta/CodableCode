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

enum UniqueTypeKey: Hashable {
    case structKey([ProductType.Property])
    case sumKey(relatedTypes: [TypeOption])
}

func fillUniqueTypes(root: TypeOption, uniqueTypes: inout [UniqueTypeKey: TypeOption]) {
    switch root {
    case .swiftType(_):
        // nothing to do here
        break
    case let .productType(productType):
        uniqueTypes[.structKey(productType.properties)] = .productType(productType)
        productType.properties.forEach { property in
            if let relatedType = property.relatedType {
                fillUniqueTypes(root: relatedType, uniqueTypes: &uniqueTypes)
            }
        }
    case let .sumType(sumType):
        uniqueTypes[.sumKey(relatedTypes: sumType.relatedTypes)] = .sumType(sumType) // change key to cases instead of uuid or properties
        sumType.relatedTypes.forEach { option in
            fillUniqueTypes(root: option, uniqueTypes: &uniqueTypes)
        }
        break
    case let .arrayType(arrayType):
        fillUniqueTypes(root: arrayType.relatedType, uniqueTypes: &uniqueTypes)
        break
    case .anyType(_):
        // nothing to do here
        break
    }
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
    
    /// Self and unique sub-types used in the struct
    var selfAndRelatedSubtypes: [UniqueTypeKey: TypeOption] {
        var uniqueTypes = [UniqueTypeKey: TypeOption]()
        fillUniqueTypes(root: .productType(self), uniqueTypes: &uniqueTypes)
        return uniqueTypes
    }
    
    static func implementation(productType: ProductType, uniqueTypes: [UniqueTypeKey: TypeOption]) -> [String] {
        var implementation = [String]()
        implementation += ["\(productType.structOrClass) \(productType.name.asType): Codable {"]
        
        // create – let <symbol>: <type><optional-syntactic-suggar>
        let properties = productType.properties
            .map { (property) -> String in
                // get the name from the uniquetype list.
                let typeName: String
                if case let .productType(relatedProductType) = property.relatedType,
                   case let .productType(relatedProductType2) = uniqueTypes[.structKey(relatedProductType.properties)] {
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
    var linesOfCode: [String] {
        let structs = selfAndRelatedSubtypes
            .map { (pair) -> String in
                let (_, typeOption) = pair
               
                switch typeOption {
                case .swiftType(_):
                    fatalError()
                    break
                case let .productType(productType):
                    return ProductType
                        .implementation(productType: productType, uniqueTypes: selfAndRelatedSubtypes)
                        .joined(separator: "\n")
                case let .sumType(sumType):
                    return SumType.implementation(sumType: sumType)
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
    
    var code: String {
        let code = linesOfCode.joined(separator: "\n")
        return code
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
                        dictionary: jsonObject
                    )
                    name = productType.name
                    relatedType = .productType(productType)
                case let jsonObjects as [Any]:
                    let arrayType = try ArrayType(
                        jsonObjects: jsonObjects,
                        name: key.asType
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

indirect enum TypeOption: Hashable, Equatable, Comparable {
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
            return arrayType.name
        case let .anyType(anyType):
            return anyType.name
        }
    }
    
    static func < (lhs: TypeOption, rhs: TypeOption) -> Bool {
        return lhs.name < rhs.name
    }
    
    /// Returns Swift Type or Codable type
    /// - Parameter jsonObject: Any object that
    /// - Returns: Either a swiftType or a Codable Type
    static func type(for jsonObject: Any, name: String = "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON") throws -> TypeOption? {
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
                name: name,
                dictionary: dictionary
            )
            typeOption = .productType(productType)
        case let jsonObjects as [Any]:
            let arrayType = try ArrayType(
                jsonObjects: jsonObjects,
                name: name
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
    
    var name: String {
        return rawValue
    }
}

struct SumType: Equatable, Hashable {
    let name: String
    let relatedTypes: [TypeOption]
    
    init(typeOptions: [TypeOption], name: String) {
        self.name = name
        self.relatedTypes = Array(typeOptions.uniqued().sorted())
    }
    
    static func implementation(sumType: SumType) -> [String] {
        var code = [String]()
        code += ["enum \(sumType.name): Codable {"]
        sumType.relatedTypes.uniqued().forEach { relatedType in
            code += ["case \(relatedType.name.asSymbol)(\(relatedType.name))".idented]
        }
        code += ["}"]
        return code
    }
}

struct ArrayType: Equatable, Hashable {
    var name: String {
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
            guard let typeOption = try TypeOption.type(for: jsonObject, name: name.asType) else {
                fatalError()
            }
            typeOptions.append(typeOption)
        }
        
        let set = Set<TypeOption>(typeOptions)
        if set.count == 1 {
            self.relatedType = set.first!
        } else {
            switch config {
            case .optionals:
                self.relatedType = .sumType(.init(typeOptions: [], name: ""))
                fatalError("Not supported")
            case .enums:
                self.relatedType = .sumType(.init(typeOptions: typeOptions, name: name.asType))
            }
        }
    }
}

struct AnyType: Equatable, Hashable {
    let name = "Any"
}

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
        
        // We want to be able to convert also typeNames of the type [String] to case string([String])
        // so we remove the "[]" from the string
        string.removeAll { $0 == "[" || $0 == "]" }
        
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
   
    func name(namesAlreadyUsed: inout [String]) -> String {
        guard !namesAlreadyUsed.contains(self) else {
            
            let lastCount = namesAlreadyUsed
                .filter { name in
                    return name.hasPrefix(self) // filter to check if we have the prefix
                }
                .map {
                    $0.dropFirst(self.count)    // remove the prefix and leave only a suffix
                }
                .compactMap { Int($0) }         // try to turn the suffix into a number
                .sorted()                       // sort it
                .last                           // get the last element
                
            guard let lastCount = lastCount else {
                return self + "1"
            }
            
            return self + "\(lastCount + 1)"
        }
        return self
    }
    
    /// Get the Codable code from the provided JSON
    /// - Parameter name: The name of the struct, if no struct is provided you'll get a placeholder of the type <#SomeType#>
    /// - Returns: The codable code as a string.
    public func codableCode(name: String = "<#SomeType#>") throws -> String {
        let dictionary = try dictionary()
        let productType = try ProductType.productType(name: name, dictionary: dictionary)
        return productType.code
    }
}

/// Function used for printing.
/// - Parameters:
///   - file: The file at which the function was called from.
///   - line: The line at whic the function was called from.
///   - output: The string to be printed.
func dump2(file: String = #file, line: Int = #line, _ output: String) {
    print(">>> \(output)\t|\(file):\(line)")
}
