
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
