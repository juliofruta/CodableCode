# String + CodableCode
## Instance Property
# CodableCode

Codable code is a Swift Package that allows you to convert JSON Strings into Swift structs.

-------------------------

The following code:

```
print("""
{
  "greeting": "Welcome to quicktype!",
  "instructions": [
    "Type or paste JSON here",
    "Or choose a sample above",
    "quicktype will generate code in your",
    "chosen language to parse the sample data"
  ]
}
""".codableCode!)
```

Outputs:

```
struct <#SomeType#>: Codable {
    let greeting: String
    let instructions: [String]
}
```

-------------------------

## Declaration 
```
var codableCode: String? { get }
```

## See Also

### Throwing an error and setting a type name
```
func makeCodableCode(name:) throws
```
