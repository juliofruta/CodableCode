
struct MemoizedTypes {
    
    /// What makes a type unique?
    /// Types are special cases of sets. 
    /// Subdivided in two.
    /// - Sum types
    /// - Product types.
    /// For Sum types a Sum will be the same as another is all the related cases are the same
    /// And for the struct the same.
    enum Cases: Hashable {
        // The properties are the keys of the struct.
        case structKey([ProductType.Property])
        
        // The related types are the keys of the enum.
        case sumKey(relatedTypes: [TypeOption])
    }
    
    // what i want here is to have unique names as well.
    private var typesIndexedByCases: [Cases: TypeOption]
    
    init() {
        typesIndexedByCases = .init()
    }
    
    fileprivate subscript(_ key: Cases) -> TypeOption? {
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
    
    /// Lines of code of all the structs to be printed.
    func linesOfCode() -> [String] {
        var memoizedTypes = self
        let structs = memoizedTypes
            .allTypes
            .map { (typeOption) -> String in
                switch typeOption {
                case .swiftType(_):
                    fatalError()
                    break
                case let .productType(productType):
                    return ProductType
                        .implementation(productType: productType, memoizedTypes: &memoizedTypes)
                        .joined(separator: "\n")
                case let .sumType(sumType):
                    return SumType
                        .implementation(sumType: sumType, memoizedTypes: &memoizedTypes)
                        .joined(separator: "\n")
                case .arrayType(_):
                    fatalError()
                    break
                case .anyType(_):
                    fatalError()
                    break
                }
            }
        let linesOfCode = structs
            .uniqued() // We don't want to repeat code
            .sorted()  // We want to sort the types alphabetically
        return linesOfCode
    }

    func code() -> String {
        let code = linesOfCode().joined(separator: "\n")
        return code
    }
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
        // Añade el product type al memoized types.
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
