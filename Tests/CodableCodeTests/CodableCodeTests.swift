import XCTest
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    func testEmptyJSON() throws {
        XCTAssertEqual("".codableCode, nil)
    }
    
    func testA() throws {
        XCTAssertEqual("""
            {
              "greeting": "Welcome to quicktype!",
              "instructions": [
                "Type or paste JSON here",
                "Or choose a sample above",
                "quicktype will generate code in your",
                "chosen language to parse the sample data"
              ]
            }
            """.codableCode, """
            struct <#SomeType#>: Codable {
                let greeting: String
                let instructions: [String]
            }
            """
        )
    }
    
    func testB() throws {
        XCTAssertEqual(
            """
            { "array" : [   ] }
            """.codableCode,
            """
            struct <#SomeType#>: Codable {
                let array: [Any]
            }
            """
        )
    }
    
    func testC() throws {
        XCTAssertEqual(
            """
            {
                "greeting": "Hello world!"
            }
            """.codableCode,
            """
            struct <#SomeType#>: Codable {
                let greeting: String
            }
            """
        )
    }
    
    func testF() throws {
        XCTAssertEqual("""
        {
          "userId": 1,
          "id": 1,
          "title": "delectus aut autem",
          "completed": false
        }
        """.codableCode, """
        struct <#SomeType#>: Codable {
            let completed: Bool
            let id: Bool
            let title: String
            let userId: Bool
        }
        """)
    }
}
