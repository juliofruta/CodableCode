/// Swift types as strings.
enum SwiftType: String {
    case String = "String"
    case Bool = "Bool"
    case Decimal = "Decimal"
    case Double = "Double"
    case Int = "Int"
    
    var name: String {
        return rawValue
    }
}
