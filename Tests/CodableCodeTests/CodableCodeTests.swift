import XCTest
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    func testEmptyJSON() throws {
        XCTAssertEqual("".codableCode, nil)
    }
    
    func testA() throws {
        test("""
            {
              "greeting": "Welcome to quicktype!",
              "instructions": [
                "Type or paste JSON here",
                "Or choose a sample above",
                "quicktype will generate code in your",
                "chosen language to parse the sample data"
              ]
            }
            """, """
            struct <#SomeType#>: Codable {
                let greeting: String
                let instructions: [String]
            }
            """
        )
    }
    
    func testB() throws {
        test(
            """
            { "array" : [   ] }
            """,
            """
            struct <#SomeType#>: Codable {
                let array: [Any]
            }
            """
        )
    }
    
    func testC() throws {
        test(
            """
            {
                "greeting": "Hello world!"
            }
            """,
            """
            struct <#SomeType#>: Codable {
                let greeting: String
            }
            """
        )
    }
    
    func testF() throws {
        test("""
        {
          "userId": 1,
          "id": 1,
          "title": "delectus aut autem",
          "completed": false
        }
        """, """
        struct <#SomeType#>: Codable {
            let completed: Bool
            let id: Bool
            let title: String
            let userId: Bool
        }
        """)
    }
    
    func testG() throws {
        test("""
        {
            "a": [{ "a": "ok" }, { "a": "ok", "b": "ok" }, { "c": 2 }]
        }
        """, """
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
        test("""
        {
            "a1": [{ "a2": "ok" }, { "a2": "ok", "b2": "ok" }, { "c2": [{ "a3": "ok" }, { "a3": "ok", "b3": "ok" }, { "c3": "ok" }]}]
        }
        """, """
        struct <#SomeType#>: Codable {
            let a1: [A1]
            struct A1: Codable {
                struct C2: Codable {
                    let a3: String?
                    let b3: String?
                    let c3: String?
                }
                let a2: String?
                let b2: String?
                let c2: [C2]?
            }
        }
        """)
    }
    
    
    enum Error: Swift.Error {
        case unexpectedResult
    }
    
    func test(_ jsonString: String, _ expectedResult: String?)  {
        guard let codableCode = jsonString.codableCode else {
            guard expectedResult == nil else {
                XCTFail()
                return
            }
            return
        }
        
        guard let expectedResult = expectedResult else {
            XCTFail()
            return
        }
        
        guard codableCode == expectedResult else {
            print("json string")
            jsonString.printEscaping()
            print("codable code")
            codableCode.printEscaping()
            print("expected result")
            expectedResult.printEscaping()
            XCTFail()
            return
        }
    }
    
}
