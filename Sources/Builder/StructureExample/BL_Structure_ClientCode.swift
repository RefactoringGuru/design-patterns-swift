//
//  BL_Structure_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Builder Design Pattern
///
/// Intent: Separate the construction of a complex object from its representation so
/// that the same construction process can create different representations.

class BL_Structure_ClientCode_Tests: XCTestCase {
    
    func testStructureBuilder() {
        clientCode(director: Director())
    }
    
    func clientCode(director: Director) {
        
        /// Client code may reuse single instance of the Director. It creates builder
        /// objects and passes them to director and then initiates the construction
        /// process. The end result is returned by the builder.
        
        let builder = ConcreteBuilder1()
        director.update(builder: builder)
        print("Standard basic product:")
        
        director.buildMinimalViableProduct()
        print(builder.retrieveProduct().listParts())
        print("Standard full featured product:")
        
        director.buildFullFeaturedProduct()
        print(builder.retrieveProduct().listParts())
        
        /// By the way, builder can be used without a director.
        print("Custom product:")
        builder.producePartA()
        builder.producePartC()
        print(builder.retrieveProduct().listParts())
    }
}
