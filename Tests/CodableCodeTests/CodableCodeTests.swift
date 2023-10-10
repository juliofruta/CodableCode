import XCTest
import CustomDump
@testable import CodableCode



final class CodableCodeTests: XCTestCase {
    
    /// Test that we are returning an error if an empty string is passed.
    func testEmptyJSON() throws {
        try test("", .failure(NSError(domain: NSCocoaErrorDomain, code: 3840)))
    }
    
    /// Test sample JSON from quicktype.io
    func testSimpleStruct() throws {
        try test(
            """
            {
              "greeting": "Welcome to quicktype!",
              "instructions": [
                "Type or paste JSON here",
                "Or choose a sample above",
                "quicktype will generate code in your",
                "chosen language to parse the sample data"
              ]
            }
            """,
            .success(
                """
                struct SomeType: Codable {
                    let greeting: String
                    let instructions: [String]
                    enum CodingKeys: String, CodingKey {
                        case greeting = "greeting"
                        case instructions = "instructions"
                    }
                }
                """
            )
        )
    }
    
    func testStructWithStructs() throws {
        try test(
           """
           {
             "person": {
               "name": "John Doe",
               "age": 30,
               "address": {
                 "street": "123 Main St",
                 "city": "Cityville",
                 "state": "CA",
                 "postalCode": "12345"
               },
               "phoneNumbers": [
                 {
                   "type": "home",
                   "number": "555-1234"
                 },
                 {
                   "type": "work",
                   "number": "555-5678"
                 }
               ],
               "isStudent": false,
               "grades": false
             },
             "books": [
               {
                 "title": "The Catcher in the Rye",
                 "author": "J.D. Salinger",
                 "publishedYear": 1951
               },
               {
                 "title": "To Kill a Mockingbird",
                 "author": "Harper Lee",
                 "publishedYear": 1960
               }
             ],
             "tags": ["fiction", "classic", "coming-of-age"]
           }
           """,
            .success(
            """
            struct Address: Codable {
                let city: String
                let postalCode: String
                let state: String
                let street: String
                enum CodingKeys: String, CodingKey {
                    case city = "city"
                    case postalCode = "postalCode"
                    case state = "state"
                    case street = "street"
                }
            }
            struct Books: Codable {
                let author: String
                let publishedYear: Double
                let title: String
                enum CodingKeys: String, CodingKey {
                    case author = "author"
                    case publishedYear = "publishedYear"
                    case title = "title"
                }
            }
            struct Person: Codable {
                let address: Address
                let age: Double
                let grades: Bool
                let isStudent: Bool
                let name: String
                let phoneNumbers: [PhoneNumbers]
                enum CodingKeys: String, CodingKey {
                    case address = "address"
                    case age = "age"
                    case grades = "grades"
                    case isStudent = "isStudent"
                    case name = "name"
                    case phoneNumbers = "phoneNumbers"
                }
            }
            struct PhoneNumbers: Codable {
                let number: String
                let type: String
                enum CodingKeys: String, CodingKey {
                    case number = "number"
                    case type = "type"
                }
            }
            struct SomeType: Codable {
                let books: [Books]
                let person: Person
                let tags: [String]
                enum CodingKeys: String, CodingKey {
                    case books = "books"
                    case person = "person"
                    case tags = "tags"
                }
            }
            """
            )
        )
    }
    
    func test4LevelsDeep() throws {
        try test(
        """
        {
          "level1": {
            "key1": "value1",
            "level2": {
              "key2": "value2",
              "level3": {
                "key3": "value3",
                "level4": {
                  "key4": "value4"
                }
              }
            }
          }
        }
        """,
            .success(
                """
                struct Level1: Codable {
                    let key1: String
                    let level2: Level2
                    enum CodingKeys: String, CodingKey {
                        case key1 = "key1"
                        case level2 = "level2"
                    }
                }
                struct Level2: Codable {
                    let key2: String
                    let level3: Level3
                    enum CodingKeys: String, CodingKey {
                        case key2 = "key2"
                        case level3 = "level3"
                    }
                }
                struct Level3: Codable {
                    let key3: String
                    let level4: Level4
                    enum CodingKeys: String, CodingKey {
                        case key3 = "key3"
                        case level4 = "level4"
                    }
                }
                struct Level4: Codable {
                    let key4: String
                    enum CodingKeys: String, CodingKey {
                        case key4 = "key4"
                    }
                }
                struct SomeType: Codable {
                    let level1: Level1
                    enum CodingKeys: String, CodingKey {
                        case level1 = "level1"
                    }
                }
                """
            )
        )
    }
    
    func testArrayWithMultipleTypes() throws {
        try test("""
        {
         "a" : [
              "hola",
              1
              ]
        }
        """, .success("""
        enum A: Codable {
            case bool(Bool)
            case string(String)
        }
        struct SomeType: Codable {
            let a: [A]
            enum CodingKeys: String, CodingKey {
                case a = "a"
            }
        }
        """))
    }
    
    func testEmptyDictionary() throws {
        try test(
            "{}",
            .success(
                """
                struct SomeType: Codable {
                }
                """
            )
        )
    }
}
