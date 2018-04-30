//
//  Prototype_SimpleExample.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 4/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class Prototype_SimpleExample: XCTestCase {
    
    func test() {
        let car = Car.init(color: .blue)
        let copyOfCar = Car.init(original: car)
        let anotherCopy = copyOfCar.copy()
        XCTAssert(anotherCopy.color == .blue) // not a default red
    }
}

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
