import XCTest
@testable import CodableCode

final class TestKeysWithSpaces: XCTestCase {
    
    func testKeysWithSpaces() throws {
        try test(
            """
            {
                "and" : {
                    "leave" : {
                         "your": ["skin", "on", "the", "floor", 0]
                    },
                    "i cant" : [0]
                }
            }
            """,
            .success(
                """
                enum Your: Codable {
                    case bool(Bool)
                    case string(String)
                }
                struct And: Codable {
                    let i_cant: [Bool]
                    let leave: Leave
                    enum CodingKeys: String, CodingKey {
                        case i_cant = "i cant"
                        case leave = "leave"
                    }
                }
                struct Leave: Codable {
                    let your: [Your]
                    enum CodingKeys: String, CodingKey {
                        case your = "your"
                    }
                }
                struct SomeType: Codable {
                    let and: And
                    enum CodingKeys: String, CodingKey {
                        case and = "and"
                    }
                }
                """
            )
        )
    }
}
