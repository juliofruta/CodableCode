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
    
    func testG() throws {
        XCTAssertEqual("""
        {
            "a": [{ "a": "ok" }, { "a": "ok", "b": "ok" }, { "c": 2 }]
        }
        """.codableCode, """
        struct <#SomeType#>: Codable {
            let a: [A]
            struct A: Codable {
                let a: String?
                let b: String?
                let c: Double?
            }
        }
        """)
    }
    
    func testH() throws {
        print("""
        {
            "a": [{ "a": "ok" }, { "a": "ok", "b": "ok" }, { "c":
                [
                                 [{ "a": "ok" }, { "a": "ok", "b": "ok" }, { "c":
                                    [
                                    
                                    ]
                                }]
                ]
            }]
        }
        """.codableCode)
    }
}
