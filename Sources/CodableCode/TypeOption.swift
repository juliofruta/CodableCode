import Foundation

indirect enum TypeOption: Hashable, Equatable, Comparable {
    
    case swiftType(SwiftType)
    case productType(ProductType)
    case sumType(SumType)
    case arrayType(ArrayType)
    case anyType(AnyType)
    
    var name: String {
        switch self {
        case let .swiftType(swiftType):
            return swiftType.rawValue
        case let .productType(productType):
            return productType.name
        case let .sumType(sumType):
            return sumType.name
        case let .arrayType(arrayType):
            return arrayType.name
        case let .anyType(anyType):
            return anyType.name
        }
    }
    
    static func < (lhs: TypeOption, rhs: TypeOption) -> Bool {
        return lhs.name < rhs.name
    }
    
    /// Returns Swift Type or Codable type
    /// - Parameter jsonObject: Any object that
    /// - Returns: Either a swiftType or a Codable Type
    static func type(for jsonObject: Any, name: String = "TYPE_IMPLEMENTATION_USED_FOR_COMPARISON", memoizedTypes: inout MemoizedTypes) throws -> TypeOption? {
        var typeOption: TypeOption?
        switch jsonObject {
        case _ as String:
            typeOption = .swiftType(.String)
        case _ as Bool:
            typeOption = .swiftType(.Bool)
        case _ as Decimal:
            typeOption = .swiftType(.Decimal)
        case _ as Double:
            typeOption = .swiftType(.Double)
        case _ as Int:
            typeOption = .swiftType(.Int)
        case let dictionary as [String: Any]:
            let productType = try ProductType.productType(
                name: name,
                dictionary: dictionary,
                memoizedTypes: &memoizedTypes
            )
            typeOption = .productType(productType)
        case let jsonObjects as [Any]:
            let arrayType = try ArrayType(
                jsonObjects: jsonObjects,
                name: name,
                memoizedTypes: &memoizedTypes
            )
            typeOption = .arrayType(arrayType)
        default:
            assertionFailure()
        }
        return typeOption
    }
}
