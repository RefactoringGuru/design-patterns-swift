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

/// Base Builder interface specifies operations for creating parts of a
/// Product object.

protocol Builder {
    
    func producePartA()
    func producePartB()
    func producePartC()
}

/// Concrete Builders implement the common Builder interface and provide specific
/// implementations of the building steps. Program may have several Builder
/// variations with different implementations.

class ConcreteBuilder1: Builder {
    
    private var product = Product1()
    
    /// New builder already contains a blank product that will be used in
    /// further assembly.
    
    func reset() {
        product = Product1()
    }
    
    /// All production steps work with the same product instance.
    
    func producePartA() {
        product.add(part: "PartA1")
    }
    
    func producePartB() {
        product.add(part: "PartB1")
    }
    
    func producePartC() {
        product.add(part: "PartC1")
    }
    
    /// Provide an interface for retrieving the product. Builders may create
    /// different product types. That's why this method is not defined in base
    /// interface.
    ///
    /// Once product is completed, prepare a blank product object so that new
    /// product could be built.
    
    func retrieveProduct() -> Product1 {
        let result = self.product
        reset()
        return result
    }
}

/// Director controls sequence of building steps, while delegating most of the
/// work to a Builder instance.

class Director {
    
    private var builder: Builder?
    
    /// Director works with any Builder instance client code passes to it.
    /// This way, client code may vary the type of product that will be
    /// produced in the end.
    
    func update(builder: Builder) {
        self.builder = builder
    }
    
    /// Director can construct several product variations using the same building
    /// steps.
    
    func buildMinimalViableProduct() {
        builder?.producePartA()
    }
    
    func buildFullFeaturedProduct() {
        builder?.producePartA()
        builder?.producePartB()
        builder?.producePartC()
    }
}

/// Product class represents a complex object under construction.
///
/// Unlike in other creational patterns, different builders can produce
/// unrelated products. In other words, products of different Builders don't need
/// to follow a common interface.

class Product1 {
    
    /// LinkedList can be used for the efficient insertion and saving the order
    private var parts = [String]()
    
    func add(part: String) {
        self.parts.append(part)
    }
    
    func listParts() -> String {
        return "Product parts: " + parts.flatMap({ $0 + "," }) + "\n"
    }
}
