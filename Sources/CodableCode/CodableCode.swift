import Foundation
import Algorithms
import Collections

enum Error: Swift.Error {
    case invalidData
}

let identation = "    "

public struct CodableType: Equatable, Hashable {
    
    struct Property: Equatable, Hashable {
        var letOrVar = "let"
        var symbol = "symbol"
        var typeName = "Any"
        var isOptional = false
        var relatedType: CodableType?
    }
    
    let structOrClass = "struct"
    let name: String
    let properties: [Property]
    
    var description: String {
        let properties = self.properties
            .map { property in
                "\(property.letOrVar) \(property.symbol): \(property.typeName)"
            }
            .reduce("") { partialResult, line in
                return "\(partialResult + line.idented.lineBreaked)"
            }
        var description = """
                \(structOrClass) \(name): Codable {
                \(properties)
                }
                """
        description += self.properties.reduce("") { partialResult, property in
            return partialResult.lineBreaked + (property.relatedType?.description ?? "")
        }
        return description
    }
}

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
    
    var idented: String {
        identation + self
    }
    
    func printEscaping() {
        let lines = split(separator: "\n")
        lines.forEach { line in
            print(line)
        }
    }
    
    var lineBreaked: String {
        return self + "\n"
    }
    
    mutating func lineBreak() {
        self = self + "\n"
    }
    
    enum NameOrCodableType: Hashable, Equatable {
        case name(String)
        case codableType(CodableType)
    }
    
    func arrayTypeName(
        anyArray: [Any],
        key: String,
        margin: String
    ) throws -> String {
        
        var nameOrCodableTypes = Set<NameOrCodableType>()
        
        // first we assume we have an array of Any
        try anyArray.forEach { jsonObject in // then to confirm or deny that we traverse array to get a list of the different types
            
            var nameOrCodableType: NameOrCodableType?
            
            // check what type is each element of the array
            switch jsonObject {
            case let dictionary as [String: Any]: // for dictionaries
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let string = String(data: data, encoding: .utf8)!
                let codableType = try string.codableType(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON")
                nameOrCodableType = .codableType(codableType)
            case _ as String:
                nameOrCodableType = .name("String")
            case _ as Bool:
                nameOrCodableType = .name("Bool")
            case _ as Decimal:
                nameOrCodableType = .name("Decimal")
            case _ as Double:
                nameOrCodableType = .name("Double")
            case _ as Int:
                nameOrCodableType = .name("Int")
            default:
                assertionFailure() // unhandled case
            }
            if let nameOrCodableType = nameOrCodableType {
                nameOrCodableTypes.insert(nameOrCodableType) // append the type to the list
            }
        }
        
        // write the type
        var swiftCode = ""
        
        if nameOrCodableTypes.count == 0 {
            swiftCode += "[Any]"
        } else if nameOrCodableTypes.count == 1 {
            var typeName = ""
            switch nameOrCodableTypes.first! {
            case .name(let name):
                typeName = name
            case .codableType(_):
                typeName = key.asType
            }
            swiftCode += "[\(typeName)]"
        } else if nameOrCodableTypes.count > 1 {
            
            let containsNames = nameOrCodableTypes.contains { nameOrCodatbleType in
                switch nameOrCodatbleType {
                case .name(_):
                    return true
                case .codableType(_):
                    return false
                }
            }
            
            let containsImplementations = nameOrCodableTypes.contains { nameOrCodableType in
                switch nameOrCodableType {
                case .name(_):
                    return false
                case .codableType(_):
                    return true
                }
            }
            
            if !containsNames && !containsImplementations {
                fatalError("Not supported")
            }
            if containsNames && !containsImplementations {
                fatalError("Not supported")
            }
            if !containsNames && containsImplementations {
                swiftCode += "[\(key.asType)]"
            }
            if containsNames && containsImplementations {
                fatalError("Not supported")
            }
            
        }
        swiftCode.lineBreak()
        return swiftCode
    }
    
    func codableType(
        anyArray: [Any],
        key: String
    ) throws -> CodableType? {
        
        var nameOrCodableTypes = Set<NameOrCodableType>()
        
        try anyArray.forEach { jsonObject in // then to confirm or deny that we traverse array to get a list of the different types
            
            var nameOrCodableType: NameOrCodableType?
            
            // check what type is each element of the array
            switch jsonObject {
            case let dictionary as [String: Any]: // for dictionaries
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let string = String(data: data, encoding: .utf8)!
                let codableType = try string.codableType(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON")
                nameOrCodableType = .codableType(codableType)
            case _ as String:
                nameOrCodableType = .name("String")
            case _ as Bool:
                nameOrCodableType = .name("Bool")
            case _ as Decimal:
                nameOrCodableType = .name("Decimal")
            case _ as Double:
                nameOrCodableType = .name("Double")
            case _ as Int:
                nameOrCodableType = .name("Int")
            default:
                assertionFailure() // unhandled case
            }
            if let nameOrCodableType = nameOrCodableType {
                nameOrCodableTypes.insert(nameOrCodableType)
            }
        }
        
        let codableTypes = nameOrCodableTypes
            .compactMap { (nameOrCodableTypes) -> CodableType? in
                switch nameOrCodableTypes {
                case .name(_):
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
            .init(letOrVar: key.letOrVar, symbol: key.symbol, typeName: key.typeName, isOptional: value == codableTypes.count, relatedType: key.relatedType)
        }
        return .init(name: key.asType, properties: propertiesWithOptionalSupport)
    }
    
    /// Compiles a valid JSON to a Codable Swift Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: Not sure if it should throw right now. We can check if the JSON is valid inside
    /// - Returns: The string of the type produced by the JSON
    public func codableType(name: String) throws -> CodableType {
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
                    guard let codableType = try codableType(anyArray: anyArray, key: key) else {
                        break
                    }
                    typeName = codableType.name
                    relatedType = codableType
                default:
                    // TODO: Add more cases like dates
                    break
                }
                return .init(symbol: key, typeName: typeName.asSymbol, isOptional: false, relatedType: relatedType)
                
            }
        return .init(name: name, properties: properties)
    }
    
    public var codableCode: String? {
        try? codableType(name: "<#SomeType#>").description
    }
}
