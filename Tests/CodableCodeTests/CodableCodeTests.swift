import XCTest
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    func testEmptyJSON() throws {
        XCTAssertEqual("".codableCode, nil)
    }
    
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
        
        guard codableCode == expectedResult else {
            print("input")
            jsonString.printEscaping()
            print("expected result")
            expectedResult?.printEscaping()
            print("actual result")
            codableCode.printEscaping()
            XCTFail()
            return
        }
    }
    
}
