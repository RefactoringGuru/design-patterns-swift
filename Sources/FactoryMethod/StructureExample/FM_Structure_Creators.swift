//
//  FM_Structure_Creators.swift
//  RefactoringGuru.Patterns
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
    
    /// Base behavior. ConcreteCreator2 overrides it.
    func someOperation() -> String {
        
        /// Call the factory method to create a Product object.
        let product = factoryMethod()
        
        /// Now, use product.
        return "Same creator's code worked with: " + product.operation()
    }
}

class ConcreteCreator1: Creator {
    
    /**
     * Override the factory method to return an instance of a ConcreteProduct1.
     */
    
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    
    /**
     * Override the factory method to return an instance of a ConcreteProduct2.
     */
    
    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
    
    func someOperation() -> String {
        
        let product = factoryMethod()
        
        return "ConcreteCreator2 overrides the base behavior: " + product.operation()
    }
}
