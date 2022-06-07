import Foundation

enum Error: Swift.Error {
    case invalidData
}

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
    
    func makeCodableTypeArray(anyArray: [Any], key: String, identation: String) throws -> String {
        var types = Set<String>()
        var existingTypes = Set<String>()
        var structCodeSet = Set<String>()
        
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
                let dummyTypeImplementation = try objectString.codableCode(name: "TYPE", identation: identation + "    ")
                
                if !existingTypes.contains(dummyTypeImplementation) {
                    existingTypes.insert(dummyTypeImplementation)
                    if existingTypes.count == 1 {
                        type = key.asType
                    } else {
                        type = key.asType + "\(existingTypes.count)"
                    }
                    let typeImplementation = try objectString.codableCode(name: type!, identation: identation + "    ")
                    structCodeSet.insert(typeImplementation)
                }
            default:
                type = ""
                assertionFailure() // unhandled case
            }
            if let unwrappedType = type {
                types.insert(unwrappedType)
            }
        }
        
        // write type
        var swiftCode = ""
        
        if types.isEmpty {
            swiftCode += "[Any]"
        } else if types.count == 1 {
            swiftCode += "[\(types.first!)]"
        } else {
            
            swiftCode += "\(key.asType)Options"
            
            // create enum
            swiftCode.lineBreak()
            swiftCode.lineBreak()
            swiftCode += identation + "    enum \(key.asType)Options: Codable {"
            
            types.forEach { type in
                swiftCode.lineBreak()
                // enum associatedTypes
                swiftCode += identation + "        case \(type.asSymbol)(\(type))"
            }
            
            swiftCode.lineBreak()
            swiftCode += identation + "    }"
        }
        
        // write implementations
        structCodeSet.forEach { implementation in
            swiftCode.lineBreak()
            swiftCode.lineBreak()
            swiftCode += implementation
            swiftCode.lineBreak()
        }
        
        return swiftCode
    }
    
    /// Compiles a valid JSON to a Codable Swift Type as in the following Grammar spec: https://www.json.org/json-en.html
    /// - Parameter json: A valid JSON string
    /// - Throws: Not sure if it should throw right now. We can check if the JSON is valid inside
    /// - Returns: The string of the type produced by the JSON
    public func codableCode(name: String, identation: String = "") throws -> String {
        var swiftCode = identation
        swiftCode += "struct \(name.asType): Codable {"
        guard let data = data(using: .utf8) else {
            throw Error.invalidData
        }
        if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            try dictionary
                .sorted(by: { $0.0 < $1.0 })
                .forEach { pair in
                let (key, value) = pair
                swiftCode.lineBreak()
                swiftCode += identation + "    let \(key.asSymbol): "
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
                    swiftCode += identation + (try objectString.codableCode(name: key, identation: identation + "    "))
                    swiftCode.lineBreak()
                case let anyArray as [Any]:
                    swiftCode += try makeCodableTypeArray(anyArray: anyArray, key: key, identation: identation)
                // TODO: Add more cases like dates
                default:
                    swiftCode += "Any"
                }
            }
        }
        swiftCode.lineBreak()
        swiftCode += identation + "}"
        return swiftCode
    }
    
    public var codableCode: String? {
        try? codableCode(name: "<#SomeType#>")
    }
}
