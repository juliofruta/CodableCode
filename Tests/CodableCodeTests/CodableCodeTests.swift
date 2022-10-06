import XCTest
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    func testEmptyJSON() throws {
        XCTAssertEqual("".codableCode, nil)
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
            print("json string")
            jsonString.printEscaping()
            print("codable code")
            codableCode.printEscaping()
            print("expected result")
            expectedResult?.printEscaping()
            XCTFail()
            return
        }
    }
    
}
