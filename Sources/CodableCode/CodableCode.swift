import Foundation
import Algorithms
import Collections

enum Error: Swift.Error {
    case invalidData
}

let identation = "    "

public struct CodableType: Equatable, Hashable {
    let implementation: String
    let subtypes: Set<CodableType>
    
    var description: String {
        var code = ""
        var implementations = Set<String>()
        dfs(&implementations)
        implementations
            .sorted()
            .forEach { implementation in
                code += implementation
                code.lineBreak()
            }
        return code
    }
    
    private func dfs(_ implementations: inout Set<String>) {
        implementations.insert(implementation)
        subtypes.forEach { codableType in
            codableType.dfs(&implementations)
        }
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
    
    func printEscaping() {
        let lines = split(separator: "\n")
        lines.forEach { line in
            print(line)
        }
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
        key: String,
        margin: String
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

        let implementations = codableTypes
            .map {
                $0.implementation
            }
        
        let subtypes = codableTypes
            .map {
                $0.subtypes
            }
            .flatMap { $0 }
            .reduce(Set<CodableType>()) { partialResult, codableType in
                var mutable = partialResult
                mutable.insert(codableType)
                return mutable
            }
        
        let arrayOfLinesWithLet = implementations.map { implementation in
            let lines = implementation.split(separator: "\n").map { String($0) }
            let linesWithLet = lines.filter { $0.contains("let") }
            return linesWithLet
        }
        
        var propertyCount = [String: Int]()
        
        arrayOfLinesWithLet.forEach { linesWithLet in
            linesWithLet.forEach { lineWithLet in
                propertyCount[lineWithLet] = propertyCount[lineWithLet, default: 0] + 1
            }
        }
        
        let letLinesIsOptionalPairs = propertyCount.map { pair in
            let (lineWithLet, count) = pair
            let isOptional = count != implementations.count
            return (lineWithLet, isOptional)
        }
        
        var implementation = ""
        implementation += "struct \(key.asType): Codable {"
        implementation.lineBreak()
        letLinesIsOptionalPairs
            .sorted { $0.0 < $1.0 }
            .forEach { (line, isOptional) in
            implementation += line + (isOptional ? "?" : "")
            implementation.lineBreak()
        }
        implementation += "}"
        
        return .init(implementation: implementation, subtypes: subtypes)
    }
    
    /// Compiles a valid JSON to a Codable Swift Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: Not sure if it should throw right now. We can check if the JSON is valid inside
    /// - Returns: The string of the type produced by the JSON
    public func codableType(name: String, margin: String = "") throws -> CodableType {
        var implementation = ""
        var subtypes = Set<CodableType>()
        implementation += margin + "struct \(name.asType): Codable {"
        guard let data = data(using: .utf8) else {
            throw Error.invalidData
        }        
        if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            try dictionary
                .sorted(by: { $0.0 < $1.0 })
                .forEach { pair in
                let (key, value) = pair
                implementation.lineBreak()
                implementation += identation + "let \(key.asSymbol): "
                switch value {
                case _ as Bool:
                    implementation += "Bool"
                case _ as String:
                    implementation += "String"
                case _ as Decimal:
                    implementation += "Decimal"
                case _ as Double:
                    implementation += "Double"
                case _ as Int:
                    implementation += "Int"
                case let jsonObject as [String: Any]:
                    let objectData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                    let objectString = String(data: objectData, encoding: .utf8)!
                    implementation += "\(key.asType)"
                    implementation.lineBreak()
                    implementation.lineBreak()
                    let codableType = try objectString.codableType(name: key, margin: margin)
                    subtypes.insert(.init(implementation: codableType.implementation, subtypes: codableType.subtypes))
                    implementation.lineBreak()
                case let anyArray as [Any]:
                    implementation += try arrayTypeName(anyArray: anyArray, key: key, margin: margin)
                    implementation.lineBreak()
                    guard let codableType = try codableType(anyArray: anyArray, key: key, margin: margin) else {
                        break
                    }
                    subtypes.insert(.init(implementation: codableType.implementation, subtypes: codableType.subtypes))
                // TODO: Add more cases like dates
                default:
                    implementation += "Any"
                }
            }
        }
        implementation.lineBreak()
        implementation += margin + "}"
        return .init(implementation: implementation, subtypes: subtypes)
    }
    
    public var codableCode: String? {
        try? codableType(name: "<#SomeType#>").description
    }
}
