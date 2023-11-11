import Foundation

struct ArrayType: Equatable, Hashable {
    var name: String {
        return "[\(relatedType.name)]"
    }
    
    let relatedType: TypeOption
    
    enum UseOptionalsOrEnums {
        case optionals // When an item is on an array element and is not in the next treats it as an optional
        case enums // When an item is on an array element and is not in the next treats it as an enum
    }
    
    init(jsonObjects: [Any], name: String, config: UseOptionalsOrEnums = .enums, memoizedTypes: inout MemoizedTypes) throws {
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
