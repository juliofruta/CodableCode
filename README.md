# String + CodableCode
## Instance Property
# CodableCode

Codable code is a Swift Package that allows you to convert JSON Strings into Swift structs.

-------------------------

The following code:

```
print(try! """
{
  "greeting": "Welcome to quicktype!",
  "instructions": [
    "Type or paste JSON here",
    "Or choose a sample above",
    "quicktype will generate code in your",
    "chosen language to parse the sample data"
  ]
}
""".codableCode())
```

Outputs:

```
struct <#SomeType#>: Codable {
    let greeting: String
    let instructions: [String]
    enum CodingKeys: String, CodingKey {
        case greeting = "greeting"
        case instructions = "instructions"
    }
}
```

-------------------------

## Declaration 

### Throwing an error and setting a type name
```
codableCode(name: String = "<#SomeType#>") throws -> String
```
