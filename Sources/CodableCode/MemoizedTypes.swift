
struct MemoizedTypes {
    
    // what i want here is to have unique names as well.
    private var typesIndexedByCases: [Cases: TypeOption]
    
    init() {
        typesIndexedByCases = .init()
    }
    
    subscript(_ key: Cases) -> TypeOption? {
        set {
            typesIndexedByCases[key] = newValue
        }
        get {
            return typesIndexedByCases[key]
        }
    }
    
    var allTypes: [TypeOption] {
        return typesIndexedByCases.values.map { $0 }
    }
}

/// What makes a type unique?
/// Types are special cases of sets. Subdivided in two. Sum types and Product types.
/// For Sum types a Sum will be the same as another is all the related cases are the same
/// And for the struct the same.
enum Cases: Hashable {
    // The properties are the keys of the struct.
    case structKey([ProductType.Property])
    
    // The related types are the keys of the enum.
    case sumKey(relatedTypes: [TypeOption])
}

/// Adds the typeOption and it's tree to the store of unique types.
/// - Parameters:
///   - typeOption: The type option tree to be added.
///   - memoizedTypes: The type to which is being added.
func add(_ typeOption: TypeOption, to memoizedTypes: inout MemoizedTypes) {
    switch typeOption {
    case .swiftType(_):
        // nothing to do here
        break
    case let .productType(productType):
        memoizedTypes[.structKey(productType.properties)] = .productType(productType)
        productType.properties.forEach { property in
            if let relatedType = property.relatedType {
                add(relatedType, to: &memoizedTypes)
            }
        }
    case let .sumType(sumType):
        memoizedTypes[.sumKey(relatedTypes: sumType.relatedTypes)] = .sumType(sumType) // change key to cases instead of uuid or properties
        sumType.relatedTypes.forEach { option in
            add(option, to: &memoizedTypes)
        }
    case let .arrayType(arrayType):
        add(arrayType.relatedType, to: &memoizedTypes)
    case .anyType(_):
        // nothing to do here
        break
    }
}
