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
        let expected = expectedResult?.removingWhitespace
        let result = jsonString.codableCode?.removingWhitespace
        guard let result = result else {
            guard expectedResult == nil else {
                XCTFail()
                return
            }
            return
        }
        guard expected == result else {
            print("input")
            jsonString.printEscaping()
            print("expected result")
            expected?.printEscaping()
            print("actual result")
            result.printEscaping()
            XCTFail()
            return
        }
    }
}
