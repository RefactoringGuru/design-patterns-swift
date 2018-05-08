//
//  AF_Structure_ClientCode.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/**
 * Abstract Factory Design Pattern
 *
 * Intent: Provide an interface for creating families of related or dependent
 * objects without specifying their concrete classes.
 */

class AF_Structure_ClientCode_Tests: XCTestCase {
    
    /**
     * The client code works with factories and products only through abstract
     * types: AbstractFactory and AbstractProducts. This let you pass any subtype of
     * the factory or product to the client code without breaking it.
     */
    
    func testAbstractFactoryStructure() {
        /**
         * The client code can work with any concrete factory class.
         */
        print("Testing client code with the first factory type:\n")
        clientCode(factory: ConcreteFactory1())
        
        print("Testing the same client code with the second factory type:\n")
        clientCode(factory: ConcreteFactory2())
    }
    
    func clientCode(factory: AbstractFactory) {
        let productA = factory.createProductA()
        let productB = factory.createProductB()
        
        print(productB.usefulFunctionB())
        print(productB.anotherUsefulFunctionB(collaborator: productA))
    }
}
