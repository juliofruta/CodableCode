
struct SumType: Equatable, Hashable {
    let name: String
    let relatedTypes: [TypeOption]
    
    init(typeOptions: [TypeOption], name: String) {
        self.name = name
        self.relatedTypes = Array(typeOptions.uniqued().sorted())
    }
    
    static func implementation(sumType: SumType, memoizedTypes: inout MemoizedTypes) -> [String] {
        var code = [String]()
        code += ["enum \(sumType.name): Codable {"]
        sumType.relatedTypes.uniqued().forEach { relatedType in
            code += ["case \(relatedType.name.asSymbol)(\(relatedType.name))".idented]
        }
        code += ["}"]
        return code
    }
    
    // TODO: Add the following case.
    // enum Your: Codable {
    //     case integer(Int)
    //     case string(String)
    //
    //     init(from decoder: Decoder) throws {
    //         let container = try decoder.singleValueContainer()
    //         if let x = try? container.decode(Int.self) {
    //             self = .integer(x)
    //             return
    //         }
    //         if let x = try? container.decode(String.self) {
    //             self = .string(x)
    //             return
    //         }
    //         throw DecodingError.typeMismatch(Your.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Your"))
    //     }
    //
    //     func encode(to encoder: Encoder) throws {
    //         var container = encoder.singleValueContainer()
    //         switch self {
    //         case .integer(let x):
    //             try container.encode(x)
    //         case .string(let x):
    //             try container.encode(x)
    //         }
    //     }
    // }
}
