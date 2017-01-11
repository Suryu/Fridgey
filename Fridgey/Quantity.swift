//
//  Quantity.swift
//  Fridgey
//
//  Created by Paweł Wojtkowiak on 02.01.2017.
//  Copyright © 2017 Paweł Wojtkowiak. All rights reserved.
//

import Foundation

extension Double {
    var cleanValue: String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        } else {
            return String(self)
        }
    }
}

enum QuantityUnit {
    case Units
    case Weight(WeightUnit)
    case Volume(VolumeUnit)
    case Custom(prefix: String, suffix: String)
}

extension QuantityUnit: Equatable {
    static func ==(lhs: QuantityUnit, rhs: QuantityUnit) -> Bool {
        switch (lhs, rhs) {
        case (.Units, .Units):
            return true
        case (.Weight(_), .Weight(_)):
            return true
        case (.Volume(_), .Volume(_)):
            return true
        case (.Custom(_, _), .Custom(_, _)):
            return true
        default:
            return false
        }
    }
}

protocol UnitProtocol {
    var prefix: String { get }
    var suffix: String { get }
    func toString(withValue value: Double) -> String
}

extension UnitProtocol {
    func toString(withValue value: Double) -> String {
        return "\(self.prefix)\(value.cleanValue)\(self.suffix)"
    }
}

enum WeightUnit: Double, UnitProtocol {
    case Gram = 1.0
    case Decagram = 10.0
    case Kilogram = 1000.0
    
    var prefix: String {
        return ""
    }
    
    var suffix: String {
        switch (self) {
        case .Gram:
            return " g"
        case .Decagram:
            return " dag"
        case .Kilogram:
            return " kg"
        }
    }
}

enum VolumeUnit: Double, UnitProtocol {
    case Mililiter = 1.0
    case Liter = 1000.0
    
    var prefix: String {
        return ""
    }
    
    var suffix: String {
        switch (self) {
        case .Mililiter:
            return " ml"
        case .Liter:
            return " l"
        }
    }
}

struct Quantity {
    
    var amount: Double = 0.0
    private(set) var unit = QuantityUnit.Units
    
    init(_ amount: Double, unit: QuantityUnit = .Units) {
        self.amount = amount
        self.unit = unit
    }
    
    init() {
        self.amount = 1
        self.unit = .Units
    }
    
    init(rawValue raw: (prefix: String, value: Double, suffix: String)) {
        self.amount = raw.value
        switch ((raw.prefix, raw.suffix)) {
        case ("x", ""):
            self.unit = .Units
        case ("", " g"):
            self.unit = .Weight(.Gram)
        case ("", " dag"):
            self.unit = .Weight(.Decagram)
        case ("", " kg"):
            self.unit = .Weight(.Kilogram)
        case ("", " ml"):
            self.unit = .Volume(.Mililiter)
        case ("", " l"):
            self.unit = .Volume(.Liter)
        default:
            self.unit = .Custom(prefix: raw.prefix, suffix: raw.suffix)
        }
    }
    
    func toString() -> String {
        
        switch (unit) {
        case .Units:
            return "x\(amount.cleanValue)"
        case .Weight(let unitValue):
            return unitValue.toString(withValue: amount)
        case .Volume(let unitValue):
            return unitValue.toString(withValue: amount)
        case .Custom(let prefix, let suffix):
            return "\(prefix) \(amount.cleanValue) \(suffix)".trimmingCharacters(in: CharacterSet(charactersIn: " "))
        }
        
    }
    
    func toRaw() -> (prefix: String, value: Double, suffix: String) {
        switch (unit) {
        case .Units:
            return ("x", self.amount, "")
        case .Weight(let unitValue):
            return (unitValue.prefix, self.amount, unitValue.suffix)
        case .Volume(let unitValue):
            return (unitValue.prefix, self.amount, unitValue.suffix)
        case .Custom(let prefix, let suffix):
            return (prefix, self.amount, suffix)
        }
    }
    
    func convert(toUnit unit: QuantityUnit) -> Quantity {
        guard self.unit == unit else {
            return self
        }
        
        var q = self
        var divisor = 1.0
       
        switch (unit) {
        case .Weight(let unitValue):
            divisor = unitValue.rawValue
        case .Volume(let unitValue):
            divisor = unitValue.rawValue
        default:
            break
        }
        
        switch (q.unit) {
        case .Weight(let unitValue):
            q.amount /= divisor
            q.amount *= unitValue.rawValue
        case .Volume(let unitValue):
            q.amount /= divisor
            q.amount *= unitValue.rawValue
        default:
            break
        }
        
        q.unit = unit        
        return q
    }
    
}
