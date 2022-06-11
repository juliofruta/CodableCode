## Instance Property
# CodableCode
A String value indicating the generated Swift code that implements a Codable struct for the current instance if it is a valid JSON.

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
