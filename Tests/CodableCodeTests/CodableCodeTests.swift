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
        // TODO: Fix this!
        let a = """
        {
            "a1": [{ "a2": "ok" }, { "a2": "ok", "b2": "ok" }, { "c2": [{ "a3": "ok" }, { "a3": "ok", "b3": "ok" }, { "c3": "ok" }]}]
        }
        """.codableCode
        for line in a!.split(separator: "\n") {
            print(line)
        }
    }
    
    func testI() throws {
        let a = """
        {
            "success": true,
            "payload": [
                {
                    "method": "btc",
                    "name": "Bitcoin",
                    "network_name": "Bitcoin Network",
                    "network_description": "Send to an address of the Bitcoin network with a fee.",
                    "required_fields": [
                        "address"
                    ],
                    "optional_fields": [
                        "origin_id",
                        "client_withdrawal_id",
                        "max_fee"
                    ],
                    "currency_configurations": [
                        {
                            "currency": "btc",
                            "legal_operating_entity": {
                                "legal_operation_entity": "Bitso International",
                                "country_code": "GI"
                            },
                            "fee": {
                                "amount": "0.00002999",
                                "type": "fixed"
                            },
                            "limits": {
                                "system_min": "0.00002730",
                                "system_max": "0.01002858",
                                "tx_limit": "0.01002858"
                            },
                            "status": {
                                "type": "active",
                                "description": "Ok"
                            },
                            "asset": "btc"
                        }
                    ],
                    "network": "btc",
                    "protocol": "btc",
                }
            ]
        }
        """.codableCode
        for line in a!.split(separator: "\n") {
            print(line)
        }
    }
}
