//
//  QuantityTests.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 08.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import XCTest
import Fridgey

class QuantityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVolume() {
        let q = Quantity(3.5, unit: .Volume(.Mililiter))
        XCTAssertEqual(q.amount, 3.5, "Amount is not equal to 3.5 (is: \(q.amount))")
        XCTAssertEqual(q.unit, .Volume(.Mililiter), "Wrong unit assignment (is: \(q.unit))")
        XCTAssertEqual(q.toString(), "3.5 ml", "String is not equal to 3.5 (is: \(q.toString()))")
    }
    
    func testVolumeConversion() {
        
        let q = Quantity(3.5, unit: .Volume(.Mililiter)).convert(toUnit: .Volume(.Liter))
        XCTAssertEqual(q.amount, 0.0035, "Amount is not equal to 0.0035 after conversion to liters (is: \(q.amount))")
        XCTAssertEqual(q.unit, .Volume(.Liter), "Unit did not change to liters after conversion (is: \(q.unit))")
        XCTAssertEqual(q.toString(), "0.0035 l", "Invalid string after conversion (is: \(q.toString()))")
        
    }
    
    func testVolumeInvalidConversion() {
        
        let q = Quantity(3.5, unit: .Volume(.Mililiter)).convert(toUnit: .Weight(.Gram))
        XCTAssertEqual(q.amount, 3.5, "Amount is not equal to 3.5 (is: \(q.amount))")
        XCTAssertEqual(q.unit, .Volume(.Mililiter), "Wrong unit assignment (is: \(q.unit))")
        XCTAssertEqual(q.toString(), "3.5 ml", "String is not equal to 3.5 (is: \(q.toString()))")
        
    }
    
}
