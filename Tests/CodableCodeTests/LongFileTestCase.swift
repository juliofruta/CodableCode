//
//  LongFileTestCase.swift
//  
//
//  Created by Julio Cesar Guzman Villanueva on 10/30/23.
//

import XCTest

final class LongFileTestCase: XCTestCase {
    func testExample() throws {
        try test(
            file: "/Users/juliocesarguzmanvillanueva/Documents/GitHub/CodableCode/Tests/CodableCodeTests/long.json", 
            .success("")
        )
    }
}
