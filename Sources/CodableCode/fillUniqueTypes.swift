enum UniqueTypeKey: Hashable {
    case structKey([ProductType.Property])
    case sumKey(relatedTypes: [TypeOption])
}

func fillUniqueTypes(root: TypeOption, uniqueTypes: inout [UniqueTypeKey: TypeOption]) {
    switch root {
    case .swiftType(_):
        // nothing to do here
        break
    case let .productType(productType):
        uniqueTypes[.structKey(productType.properties)] = .productType(productType)
        productType.properties.forEach { property in
            if let relatedType = property.relatedType {
                fillUniqueTypes(root: relatedType, uniqueTypes: &uniqueTypes)
            }
        }
    case let .sumType(sumType):
        uniqueTypes[.sumKey(relatedTypes: sumType.relatedTypes)] = .sumType(sumType) // change key to cases instead of uuid or properties
        sumType.relatedTypes.forEach { option in
            fillUniqueTypes(root: option, uniqueTypes: &uniqueTypes)
        }
    case let .arrayType(arrayType):
        fillUniqueTypes(root: arrayType.relatedType, uniqueTypes: &uniqueTypes)
    case .anyType(_):
        // nothing to do here
        break
    }
}
