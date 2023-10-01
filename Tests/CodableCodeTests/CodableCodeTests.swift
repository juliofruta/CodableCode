import XCTest
import CustomDump
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    
    enum Error: Swift.Error {
        case resultNotInitialized
    }
    
    /// Tests that the JSON input generates the expected code. You can check for the diff in case this fails.
    /// - Parameters:
    ///   - input: The JSON input as a String.
    ///   - expectedResult:A result having either the expected code or an error.
    func test(_ input: String, _ expectedResult: Result<String, Swift.Error>)  {
        var result: Result<String, Swift.Error> = .failure(Error.resultNotInitialized)
        do {
            let success = try input.codableCode()
            result = .success(success)
        } catch {
            result = .failure(error)
        }
        let product = (result, expectedResult)
        switch product {
        case (let .success(generatedCode), let .success(expectedCode)):
            let difference = diff(generatedCode, expectedCode)
            XCTAssert(
                difference == nil,
                "Generated code does not match expected code \(difference!)"
            )
        case (let .success(generatedCode), let .failure(expectedError)):
            XCTFail(
                "Expected error: \(expectedError) but got generated code \(generatedCode)"
            )
        case (let .failure(error), let .success(expectedCode)):
            XCTFail(
                "Expected code: \(expectedCode) but got error: \(error)"
            )
        case (let .failure(error), let .failure(expectedError)):
            XCTAssert(
                error.localizedDescription == expectedError.localizedDescription,
                "Expected \(expectedError) but got \(error)"
            )
        }
    }
    
    /// Test that we are returning an error if an empty string is passed.
    func testEmptyJSON() {
        test("", .failure(NSError(domain: NSCocoaErrorDomain, code: 3840)))
    }
    
    /// Test sample JSON from quicktype.io
    func testA() {
        test(
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
                struct <#SomeType#>: Codable {
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
    
    func testB() {
        test(
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
               "grades": null
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
            struct PhoneNumbers: Codable {
                let number: String
                let type: String    
                enum CodingKeys: String, CodingKey {
                    case number = "number"
                    case type = "type"
                }
            }
            struct Person: Codable {
                let address: Address
                let age: Double
                let grades: Any
                let isStudent: Bool
                let name: String
                let phoneNumbers: PhoneNumbers    enum CodingKeys: String, CodingKey {
                    case address = "address"
                    case age = "age"
                    case grades = "grades"
                    case isStudent = "isStudent"
                    case name = "name"
                    case phoneNumbers = "phoneNumbers"
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
            struct <#SomeType#>: Codable {
                let books: Books
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
}
