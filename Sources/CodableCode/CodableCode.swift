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
    
    enum NameOrImplementation: Hashable {
        case name(String)
        case implementation(String)
    }
    
    // TODO: Instead of enum refactor to use optionals where needed.
    // Build Swift Build package plugin
    // use diffing algorithm to introduce optionals?
    // strategies:
    // create
    // 1. enum withassociated types
    // 2. optionals where needed
    // 3. optionals everywhere
    func makeArrayType(
        anyArray: [Any],
        key: String,
        margin: String
    ) throws -> String {
        
        var nameOrImplementations = Set<NameOrImplementation>()
        
        // first we assume we have an array of Any
        try anyArray.forEach { jsonObject in // then to confirm or deny that we traverse array to get a list of the different types
            
            var nameOrImplementation: NameOrImplementation?
            
            // check what type is each element of the array
            switch jsonObject {
            case let dictionary as [String: Any]: // for dictionaries
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let string = String(data: data, encoding: .utf8)!
                let codableCode = try string.codableCode(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON") // create the type implementation
                nameOrImplementation = .implementation(codableCode)
            case _ as String:
                nameOrImplementation = .name("String")
            case _ as Bool:
                nameOrImplementation = .name("Bool")
            case _ as Decimal:
                nameOrImplementation = .name("Decimal")
            case _ as Double:
                nameOrImplementation = .name("Double")
            case _ as Int:
                nameOrImplementation = .name("Int")
            default:
                assertionFailure() // unhandled case
            }
            if let nameOrImplementation = nameOrImplementation {
                nameOrImplementations.insert(nameOrImplementation) // append the type to the list
            }
        }
        
        // write the type
        var swiftCode = ""
        
        if nameOrImplementations.count == 0 {
            swiftCode += "[Any]"
        } else if nameOrImplementations.count == 1 {
            var typeName = ""
            switch nameOrImplementations.first! {
            case .name(let name):
                typeName = name
            case .implementation(_):
                typeName = key.asType
            }
            swiftCode += "[\(typeName)]"
        } else if nameOrImplementations.count > 1 {
            
            let containsNames = nameOrImplementations.contains { nameOrImplementation in
                switch nameOrImplementation {
                case .name(_):
                    return true
                case .implementation(_):
                    return false
                }
            }
            
            let containsImplementations = nameOrImplementations.contains { nameOrImplementation in
                switch nameOrImplementation {
                case .name(_):
                    return false
                case .implementation(_):
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
    
    func makeTypeImplementations(
        anyArray: [Any],
        key: String,
        margin: String
    ) throws -> String {
        
        var nameOrImplementations = Set<NameOrImplementation>()
        
        try anyArray.forEach { jsonObject in // then to confirm or deny that we traverse array to get a list of the different types
            
            var nameOrImplementation: NameOrImplementation?
            
            // check what type is each element of the array
            switch jsonObject {
            case let dictionary as [String: Any]: // for dictionaries
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                let string = String(data: data, encoding: .utf8)!
                let codableCode = try string.codableCode(name: "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON") // create the type implementation
                nameOrImplementation = .implementation(codableCode)
            case _ as String:
                nameOrImplementation = .name("String")
            case _ as Bool:
                nameOrImplementation = .name("Bool")
            case _ as Decimal:
                nameOrImplementation = .name("Decimal")
            case _ as Double:
                nameOrImplementation = .name("Double")
            case _ as Int:
                nameOrImplementation = .name("Int")
            default:
                assertionFailure() // unhandled case
            }
            if let nameOrImplementation = nameOrImplementation {
                nameOrImplementations.insert(nameOrImplementation) // append the type to the list
            }
        }
        
        let implementations = nameOrImplementations.compactMap { (nameOrImplementation) -> String? in
            switch nameOrImplementation {
            case .name(_):
                return nil
            case .implementation(let implementation):
                return implementation
            }
        }
        
        guard !implementations.isEmpty else {
            return ""
        }
        
        var swiftCode = ""
        
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
        
        swiftCode += margin + "struct \(key.asType) {"
        swiftCode.lineBreak()
        letLinesIsOptionalPairs.forEach { (line, isOptional) in
            swiftCode += margin +
            line + (isOptional ? "?" : "")
            swiftCode.lineBreak()
        }
        swiftCode += margin + "}"
        
        return swiftCode
    }
    
    /// Compiles a valid JSON to a Codable Swift Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: Not sure if it should throw right now. We can check if the JSON is valid inside
    /// - Returns: The string of the type produced by the JSON
    public func codableCode(name: String, margin: String = "") throws -> (implementation: String, otherImplementations: [String]) {
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
                    swiftCode += try makeArrayType(anyArray: anyArray, key: key, margin: margin)
                    swiftCode.lineBreak()
                    swiftCode += try makeTypeImplementations(anyArray: anyArray, key: key, margin: margin)
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
