//
//  Prototype_SimpleExamples.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 4/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/**
 * Prototype Design Pattern
 *
 * Intent: Specify the kinds of objects to create using a prototypical instance,
 * and create new objects by copying this prototype.
 */

class Prototype_SimpleExample: XCTestCase {
    
    /**
     * In Swift world, objects can be copied by adopting
     * NSCopying protocol or providing a custom implementation.
     */
    
    func testPrototype_CustomCopying() {
        let car = Car.init(color: .blue)
        let copyOfCar = Car.init(original: car)
        let anotherCopy = copyOfCar.copy()
        XCTAssert(anotherCopy.color == .blue) // not a default red
    }
    
    func testPrototype_NSCopying() {
        
        let prototype = Prototype()
        prototype.update(intValue: 2, stringValue: "Value2")
        
        guard let anotherPrototype = prototype.copy() as? Prototype else {
            XCTAssert(false)
            return
        }
        XCTAssert(anotherPrototype == prototype)
    }
}

/// MARK: - Coping using a custom Copying protocol

protocol Copying {
    
    init(original: Self)
    func copy() -> Self
}

extension Copying {
    
    func copy() -> Self {
        return Self.init(original: self)
    }
}

class Car: Copying {
    
    var color = UIColor.red
    
    init(color: UIColor) {
        self.color = color
    }
    
    required convenience init(original: Car) {
        self.init(color: original.color)
    }
}

/// MARK: - Coping using NSCopying

class Prototype {
    
    private var intValue = 1
    private var stringValue = "Value"
    
    func update(intValue: Int = 1, stringValue: String = "Value") {
        self.intValue = intValue
        self.stringValue = stringValue
    }
}

extension Prototype: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        let prototype = Prototype()
        prototype.intValue = intValue
        prototype.stringValue = stringValue
        return prototype
    }
}

extension Prototype: Equatable {
    
    static func == (lhs: Prototype, rhs: Prototype) -> Bool {
        return lhs.intValue == rhs.intValue && lhs.stringValue == rhs.stringValue
    }
}
