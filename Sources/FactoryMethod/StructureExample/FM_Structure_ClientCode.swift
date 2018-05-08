//
//  FM_Structure_ClientCode.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/**
 * Factory Method Design Pattern
 *
 * Intent: Define an interface for creating an object, but let subclasses decide
 * which class to instantiate. Factory Method lets a class defer
 * instantiation to subclasses.
 */

class FM_StructureTests: XCTestCase {
    
    /**
     * Client code produces a concrete creator object of certain kind instead of
     * base creator's class. As long as client works with creators using
     * base interface, you can make it work with any creator subclass.
     */
    
    func testFactoryMethod() {
        
        /**
         * Application picks a creator's type depending on configuration or
         * environment.
         */
        
        print("Testing ConcreteCreator1:\n")
        clientCode(creator: ConcreteCreator1())
        
        print("Testing ConcreteCreator2:\n")
        clientCode(creator: ConcreteCreator2())
    }
    
    func clientCode(creator: Creator) {
        // ...
        print(creator.someOperation())
        // ...
    }
}
