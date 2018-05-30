//
//  FM_Structure_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Factory Method Design Pattern
///
/// Intent: Define an interface for creating an object, but let subclasses decide
/// which class to instantiate. Factory Method lets a class defer
/// instantiation to subclasses.

class FM_StructureTests: XCTestCase {
    
    /// Client code produces a concrete creator object of certain kind instead of
    /// base creator's class. As long as client works with creators using
    /// base interface, you can make it work with any creator subclass.
    
    func testFactoryMethod() {
        
        /// Application picks a creator's type depending on configuration or
        /// environment.
        
        print("Testing ConcreteCreator1:")
        clientCode(creator: ConcreteCreator1())
        
        print("Testing ConcreteCreator2:")
        clientCode(creator: ConcreteCreator2())
    }
    
    func clientCode(creator: Creator) {
        // ...
        print(creator.someOperation())
        // ...
    }
}

protocol Creator {
    
    /// Creator may also define a default implementation of the factory
    /// method that returns a default ConcreteProduct object.
    
    func factoryMethod() -> Product
    
    func someOperation() -> String
}

/// This extension implements a default behavior of abstract Creator.
/// The behavior can be overridden in subclasses.

extension Creator {
    
    /// Creator should have some primary business logic. Factory method
    /// acts just as a helper in such code.
    
    /// Base behavior. ConcreteCreator2 overrides it.
    func someOperation() -> String {
        
        /// Call the factory method to create a Product object.
        let product = factoryMethod()
        
        /// Now, use product.
        return "Same creator's code worked with: " + product.operation()
    }
}

class ConcreteCreator1: Creator {
    
    /// Override the factory method to return an instance of a ConcreteProduct1.
    
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    
    /// Override the factory method to return an instance of a ConcreteProduct2.
    
    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
    
    func someOperation() -> String {
        
        let product = factoryMethod()
        
        return "ConcreteCreator2 overrides the base behavior: " + product.operation()
    }
}

/// Define the interface of objects the factory method creates.

protocol Product {
    
    func operation() -> String
}

/// Implement the Product interface.

class ConcreteProduct1: Product {
    
    func operation() -> String {
        return "Result of ConcreteProduct1"
    }
}

/// Implement the Product interface.

class ConcreteProduct2: Product {
    
    func operation() -> String {
        return "Result of ConcreteProduct2"
    }
}
