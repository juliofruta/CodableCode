import Foundation
import Algorithms

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
        
        // Remove spaces from keys, to avoid build error
        string = string.replacingOccurrences(of: " ", with: "_")
        
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
    
    /// Returns a numeric sequenced name for example:
    /// 
    /// - Parameter typeNamesInUse: an list of type names already used it will be modified to include the nw name.
    /// - Returns: A new sugested name
    func uniqued(typeNamesInUse: inout [String]) -> String {
        
        let uniqueName: String
        
        defer {
            typeNamesInUse.append(uniqueName)
        }
        
        guard !typeNamesInUse.contains(self) else {
            
            let lastCount = typeNamesInUse
                .filter { name in
                    return name.hasPrefix(self)    // filter to check if we have the prefix
                }
                .map {
                    $0.dropFirst(self.count)       // remove the prefix and leave only a suffix
                }
                .compactMap { Int($0) }            // try to turn the suffix into a number
                .sorted()                          // sort it
                .last                              // get the last element
                
            guard let lastCount = lastCount else {
                uniqueName = self + "1"            // the name does not contain a number so we initialize it at one
                return uniqueName
            }
            
            uniqueName = self + "\(lastCount + 1)" // we add one to the last number
            return uniqueName
        }
        uniqueName = self                          // the name is not found so we can use it as is.
        return uniqueName
    }
    
    /// Get the Codable code from the provided JSON
    /// - Parameter name: The name of the struct, if no struct is provided you'll get a placeholder of the type <#SomeType#>
    /// - Returns: The codable code as a string.
    public func codableCode(name: String = "<#SomeType#>") throws -> String {
        let dictionary = try dictionary()
        
        var typeNamesInUse = [String]() // initializing typeNames as empty
        
        let productType = try ProductType.productType(name: name, dictionary: dictionary, typeNamesInUse: &typeNamesInUse)
        return productType.code
    }
}

