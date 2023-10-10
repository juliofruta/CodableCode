import XCTest
import CustomDump
@testable import CodableCode

extension XCTestCase {
    
    enum Error: Swift.Error {
        case resultNotInitialized
    }
    
    /// Tests that the JSON input generates the expected code. You can check for the diff in case this fails.
    /// - Parameters:
    ///   - input: The JSON input as a String.
    ///   - expectedResult:A result having either the expected code or an error.
    func test(_ input: String, _ expectedResult: Result<String, Swift.Error>) throws {
        var result: Result<String, Swift.Error> = .failure(Error.resultNotInitialized)
        do {
            let success = try input.codableCode(name: "SomeType")
            result = .success(success)
        } catch {
            result = .failure(error)
        }
        let product = (result, expectedResult)
        switch product {
        case (let .success(generatedCode), let .success(expectedCode)):
            let difference = diff(generatedCode, expectedCode)
            try compile(code: generatedCode)
            XCTAssert(
                difference == nil,
                "Generated code does not match expected code \(difference!)"
            )
        case (let .success(generatedCode), let .failure(expectedError)):
            XCTFail(
                "Expected error: \(expectedError) but got generated code \(generatedCode)"
            )
        case (let .failure(error), let .success(expectedCode)):
            XCTFail(
                "Expected code: \(expectedCode) but got error: \(error)"
            )
        case (let .failure(error), let .failure(expectedError)):
            XCTAssert(
                error.localizedDescription == expectedError.localizedDescription,
                "Expected \(expectedError) but got \(error)"
            )
        }
    }
    
    /// Creates a file and tries to compile it
    func compile(code: String) throws {
        let swiftFileName = "test.swift"
        let saveCodeIntoFile = """
                     variable=$(cat <<EOF
                     \(code)
                     EOF
                     )
                     echo "$variable" > \(swiftFileName)
                     """
        try shell(saveCodeIntoFile)
        try shell("swiftc test.swift")
    }
}
