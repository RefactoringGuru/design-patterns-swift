//
//  FM_Creators.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol Creator {
    
    /**
     * Creator may also define a default implementation of the factory
     * method that returns a default ConcreteProduct object.
     */
    func factoryMethod() -> Product
    
    func someOperation() -> String
}

/**
 * This extension implements a default behavior of abstract Creator.
 * The behavior can be overridden in subclasses.
 */

extension Creator {
    
    /**
     * Creator should have some primary business logic. Factory method
     * acts just as a helper in such code.
     */
    func someOperation() -> String {
        
        // Call the factory method to create a Product object.
        let product = factoryMethod()
        
        // Now, use product.
        return "Same creator's code worked with: " + product.operation()
    }
}

/**
 * Override the factory method to return an instance of a ConcreteProduct1.
 */
class ConcreteCreator1: Creator {
    
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

/**
 * Override the factory method to return an instance of a ConcreteProduct2.
 */
class ConcreteCreator2: Creator {
    
    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
    
    func someOperation() -> String {
        return "ConcreteCreator2 override a default behavior of 'some operation'"
    }
}
