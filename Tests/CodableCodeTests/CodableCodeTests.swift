import XCTest
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    func testEmptyJSON() throws {
        XCTAssertEqual("".codableCode, nil)
    }
    
    func testA() {
        test("""
        {
        "problems": [{
            "Diabetes":[{
                "medications":[{
                    "medicationsClasses":[{
                        "className":[{
                            "associatedDrug":[{
                                "name":"asprin",
                                "dose":"",
                                "strength":"500 mg"
                            }],
                            "associatedDrug#2":[{
                                "name":"somethingElse",
                                "dose":"",
                                "strength":"500 mg"
                            }]
                        }],
                        "className2":[{
                            "associatedDrug":[{
                                "name":"asprin",
                                "dose":"",
                                "strength":"500 mg"
                            }],
                            "associatedDrug#2":[{
                                "name":"somethingElse",
                                "dose":"",
                                "strength":"500 mg"
                            }]
                        }]
                    }]
                }],
                "labs":[{
                    "missing_field": "missing_value"
                }]
            }],
            "Asthma":[{}]
        }]}
        """
             , nil)
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
