
struct UniqueTypes {
    
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

func recursiveFunction(typeOption: TypeOption, uniqueTypes: inout UniqueTypes) {
    switch typeOption {
    case .swiftType(_):
        // nothing to do here
        break
    case let .productType(productType):
        uniqueTypes[.structKey(productType.properties)] = .productType(productType)
        productType.properties.forEach { property in
            if let relatedType = property.relatedType {
                recursiveFunction(typeOption: relatedType, uniqueTypes: &uniqueTypes)
            }
        }
    case let .sumType(sumType):
        uniqueTypes[.sumKey(relatedTypes: sumType.relatedTypes)] = .sumType(sumType) // change key to cases instead of uuid or properties
        sumType.relatedTypes.forEach { option in
            recursiveFunction(typeOption: option, uniqueTypes: &uniqueTypes)
        }
    case let .arrayType(arrayType):
        recursiveFunction(typeOption: arrayType.relatedType, uniqueTypes: &uniqueTypes)
    case .anyType(_):
        // nothing to do here
        break
    }
}
