//
//  AbstractFactoryStructuralExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Abstract Factory Design Pattern
///
/// Intent: Provide an interface for creating families of related or dependent
/// objects without specifying their concrete classes.

class AbstractFactoryStructuralExample: XCTestCase {
    
    /// The client code works with factories and products only through abstract
    /// types: AbstractFactory and AbstractProducts. This let you pass any subtype of
    /// the factory or product to the client code without breaking it.
    
    func testAbstractFactoryStructure() {
        
        /// The client code can work with any concrete factory class.
        
        print("Testing client code with the first factory type: ")
        clientCode(factory: ConcreteFactory1())
        
        print("Testing the same client code with the second factory type: ")
        clientCode(factory: ConcreteFactory2())
    }
    
    func clientCode(factory: AbstractFactory) {
        let productA = factory.createProductA()
        let productB = factory.createProductB()
        
        print(productB.usefulFunctionB())
        print(productB.anotherUsefulFunctionB(collaborator: productA))
    }
}

/// Each distinct product of a product family should have a base interface. All
/// variations of the product must implement this interface.

protocol AbstractProductA {
    
    func usefulFunctionA() -> String
}

/// Concrete Products will be created by the corresponding concrete factory.

class ConcreteProductA1: AbstractProductA {
    
    func usefulFunctionA() -> String {
        return "The result of the A1 product."
    }
}

class ConcreteProductA2: AbstractProductA {
    
    func usefulFunctionA() -> String {
        return "The result of the A2 product."
    }
}

/// The base interface of another product. Products can interact with each other,
/// however a proper interaction is possible only between products of the same
/// concrete variation.

protocol AbstractProductB {
    
    /// The ProductB is able to do its own thing...
    
    func usefulFunctionB() -> String
    
    /// ...but it also can collaborate with the ProductA.
    ///
    /// The Abstract Factory will make sure that the products it produces will be
    /// of the same variation, which will make them compatible.
    
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String
}

/// Concrete products will be created by the corresponding concrete factory.

class ConcreteProductB1: AbstractProductB {
    
    func usefulFunctionB() -> String {
        return "The result of the B1 product."
    }
    
    
    /// The B1 product is only able to work correctly with the A1 product.
    /// However, it still lists an abstract product A in its signature.
    
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B1 collaborating with the \(result)"
    }
}

class ConcreteProductB2: AbstractProductB {
    
    func usefulFunctionB() -> String {
        return "The result of the B2 product."
    }
    
    /// The B2 product is only able to work correctly with the A2 product.
    /// However, it still lists an abstract product A in its signature.
    
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B2 collaborating with the \(result)"
    }
}

/// The Abstract Factory interface declares a set of methods that return
/// different abstract products. These products are related and called a family.
/// Products of one family are usually able to collaborate between themselves. A
/// family of products may have several variations, but the products of one
/// variation are incompatible with products of another.

protocol AbstractFactory {
    
    func createProductA() -> AbstractProductA
    func createProductB() -> AbstractProductB
}

/// Concrete Factories produce a family of products that belong to a single
/// variation. The factory guarantees that resulting products will be compatible.
/// Note that signatures of the Concrete Factory's methods return an abstract
/// product, while inside the method a concrete product is instantiated.

class ConcreteFactory1: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA1()
    }
    
    func createProductB() -> AbstractProductB {
        return ConcreteProductB1()
    }
}

/// Each concrete factory has a corresponding product variation.

class ConcreteFactory2: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA2()
    }
    
    func createProductB() -> AbstractProductB {
        return ConcreteProductB2()
    }
}
