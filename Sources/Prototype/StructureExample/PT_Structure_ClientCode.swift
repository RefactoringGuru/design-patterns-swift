//
//  PT_Structure_ClientCode.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class PT_Structure_ClientCode_Tests: XCTestCase {
    
    /// In Swift, objects can be copied by adopting
    /// NSCopying protocol or providing a custom implementation.
    
    func testPrototype_Structure() {
        
        let car = Car.init(color: .blue)
        let copyOfCar = Car.init(original: car)
        let anotherCopy = copyOfCar.copy()
        
        XCTAssert(anotherCopy.color == car.color)
        XCTAssert(anotherCopy.wheels.count == car.wheels.count)
        XCTAssert(anotherCopy.name == car.name)
    }
    
    func testPrototype_Structure_copingArrayOfDifferentObjects() {
        
        let car1 = Car.init(color: .blue)
        let car2 = Car.init(color: .red)
        
        let wheels = [Wheel(size: 100), Wheel(size: 100)]
        let aircraft = Vehicle(name: "Aircraft", wheels: wheels)
        
        /// Swift automatically reduces all objects to the common interface.
        /// It allows calling 'copy' for each item.
        
        let objectsToCopy = [car1, car2, aircraft]
        let copies = objectsToCopy.compactMap({ $0.copy() })
        
        print("Original")
        print(objectsToCopy)
        
        print("Copies")
        print(copies)
    }
}
