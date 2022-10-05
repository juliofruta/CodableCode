import XCTest
@testable import CodableCode

final class CodableCodeTests: XCTestCase {
    func testEmptyJSON() throws {
        XCTAssertEqual("".codableCode, nil)
    }
    
    
    // same type detection
    // fix upper cased coding keys
    // identifica tipos con la misma estructura
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
                            "associatedDrug2":[{
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
                            "associatedDrug2":[{
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
        """, nil)
    }
    
    func testB() {
        test("""
        {
            "a":
            {
                "a":
                {
                    "a":
                    {
                        "a": "ok"
                        
                    }
                    
                }
                
            }
        }
        """, nil)
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
