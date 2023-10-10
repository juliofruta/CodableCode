//
//  File.swift
//  
//
//  Created by Julio Cesar Guzman Villanueva on 10/10/23.
//

import XCTest
@testable import CodableCode

final class NamesUnitTests: XCTestCase {
    func testNameGeneration() {
        var names = ["nombre"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names) == "nombre1")
        
        var names2 = ["nombre1"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names2) == "nombre")
        
        var names3 = ["nombre", "nombre1"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names3) == "nombre2")
        
        var names4 = ["nombre", "nombree"]
        XCTAssert("nombre".name(namesAlreadyUsed: &names4) == "nombre1")
    }
}
