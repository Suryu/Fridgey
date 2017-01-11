//
//  QuantitySpec.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 08.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation
import Quick
import Nimble

class QuantitySpec: QuickSpec {
    
    override func spec() {
        
        describe("Quantity unit") {
            it("should be 1 unit when set up with empty initializer") {
                let q = Quantity()
                expect(q.amount).to(equal(1))
                expect(q.unit).to(equal(QuantityUnit.Units))
            }
            
            context("as a weight unit") {
                it("should set up its amount and unit properly") {
                    let q = Quantity(11.23, unit: .Weight(.Decagram))
                    expect(q.amount).to(equal(11.23))
                    expect(q.unit).to(equal(QuantityUnit.Weight(.Decagram)))
                    expect(q.toString()).to(equal("11.23 dag"))
                }
                
                it("should convert from decagram to gram properly") {
                    let q = Quantity(2.34, unit: .Weight(.Decagram)).convert(toUnit: .Weight(.Gram))
                    expect(q.amount).to(equal(23.4))
                    expect(q.unit).to(equal(QuantityUnit.Weight(.Gram)))
                    expect(q.toString()).to(equal("23.4 g"))
                }
                
                it("should convert from gram to kilogram properly") {
                    let q = Quantity(12345, unit: .Weight(.Gram)).convert(toUnit: .Weight(.Kilogram))
                    expect(q.amount).to(equal(12.345))
                    expect(q.unit).to(equal(QuantityUnit.Weight(.Kilogram)))
                    expect(q.toString()).to(equal("12.345 kg"))
                }
                
                it("should not change when trying to change to another unit e.g. volume") {
                    let q = Quantity(11.23, unit: .Weight(.Gram)).convert(toUnit: .Volume(.Mililiter))
                    expect(q.amount).to(equal(11.23))
                    expect(q.unit).to(equal(QuantityUnit.Weight(.Decagram)))
                    expect(q.toString()).to(equal("11.23 g"))
                }
            }
            
            context("as a volume unit") {
                it("should set up its amount and unit properly") {
                    let q = Quantity(24.12, unit: .Volume(.Liter))
                    expect(q.amount).to(equal(24.12))
                    expect(q.unit).to(equal(QuantityUnit.Volume(.Liter)))
                    expect(q.toString()).to(equal("24.12 l"))
                }
                
                it("should convert from mililiter to liter properly") {
                    let q = Quantity(12345, unit: .Volume(.Mililiter)).convert(toUnit: .Volume(.Liter))
                    expect(q.amount).to(equal(12.345))
                    expect(q.unit).to(equal(QuantityUnit.Volume(.Liter)))
                    expect(q.toString()).to(equal("12.345 l"))
                }
                
                it("should convert from liter to mililiter properly") {
                    let q = Quantity(12.345, unit: .Volume(.Liter)).convert(toUnit: .Volume(.Mililiter))
                    expect(q.amount).to(equal(12345))
                    expect(q.unit).to(equal(QuantityUnit.Volume(.Mililiter)))
                    expect(q.toString()).to(equal("12345 ml"))
                }
                
                it("should not change when trying to change to another unit e.g. weight") {
                    let q = Quantity(11.23, unit: .Volume(.Liter)).convert(toUnit: .Weight(.Gram))
                    expect(q.amount).to(equal(11.23))
                    expect(q.unit).to(equal(QuantityUnit.Volume(.Liter)))
                    expect(q.toString()).to(equal("11.23 l"))
                }
            }
            
            context("as a units unit") {
                it("should set up its amount and unit properly") {
                    let q = Quantity(24.12, unit: .Units)
                    expect(q.amount).to(equal(24.12))
                    expect(q.unit).to(equal(QuantityUnit.Units))
                    expect(q.toString()).to(equal("x24.12"))
                }
            }
            
            context("as any unit") {
                it("should react to amount changes") {
                    var q = Quantity(24.12, unit: .Units)
                    expect(q.amount).to(equal(24.12))
                    q.amount = 123.5
                    expect(q.amount).to(equal(123.5))
                }
            }
            
            context("as custom unit") {
                it("should display string with prefix properly") {
                    let q = Quantity(11.3, unit: .Custom(prefix: "test", suffix: ""))
                    expect(q.toString()).to(equal("test 11.3"))
                }
                
                it("should display string with suffix properly") {
                    let q = Quantity(11.3, unit: .Custom(prefix: "", suffix: "test"))
                    expect(q.toString()).to(equal("11.3 test"))
                }
                
                it("should display string with both prefix and suffix properly") {
                    let q = Quantity(11.3, unit: .Custom(prefix: "prefix", suffix: "suffix"))
                    expect(q.toString()).to(equal("prefix 11.3 suffix"))
                }
            }
        }
        
    }
}
