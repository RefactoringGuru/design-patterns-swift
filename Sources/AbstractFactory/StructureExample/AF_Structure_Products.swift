//
//  AF_Structure_Products.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/**
 * Each distinct product of a product family should have a base interface. All
 * variations of the product must implement this interface.
 */
protocol AbstractProductA {
    
    func usefulFunctionA() -> String
}

/**
 * Concrete Products will be created by the corresponding concrete factory.
 */

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

/**
 * The base interface of another product. Products can interact with each other,
 * however a proper interaction is possible only between products of the same
 * concrete variation.
 */
protocol AbstractProductB {
    
    /**
     * The ProductB is able to do its own thing...
     */
    func usefulFunctionB() -> String
    
    /**
     * ...but it also can collaborate with the ProductA.
     *
     * The Abstract Factory will make sure that the products it produces will be
     * of the same variation, which will make them compatible.
     */
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String
}

/**
 * Concrete products will be created by the corresponding concrete factory.
 */
class ConcreteProductB1: AbstractProductB {
    
    func usefulFunctionB() -> String {
        return "The result of the B1 product."
    }
    
    /**
     * The B1 product is only able to work correctly with the A1 product.
     * However, it still lists an abstract product A in its signature.
     */
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B1 collaborating with the \(result)"
    }
}

class ConcreteProductB2: AbstractProductB {
    
    func usefulFunctionB() -> String {
        return "The result of the B2 product."
    }
    
    /**
     * The B2 product is only able to work correctly with the A2 product.
     * However, it still lists an abstract product A in its signature.
     */
    
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B2 collaborating with the \(result)"
    }
}
