//
//  AF_Structure_Factories.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/**
 * The Abstract Factory interface declares a set of methods that return
 * different abstract products. These products are related and called a family.
 * Products of one family are usually able to collaborate between themselves. A
 * family of products may have several variations, but the products of one
 * variation are incompatible with products of another.
 */

protocol AbstractFactory {
    
    func createProductA() -> AbstractProductA
    func createProductB() -> AbstractProductB
}

/**
 * Concrete Factories produce a family of products that belong to a single
 * variation. The factory guarantees that resulting products will be compatible.
 * Note that signatures of the Concrete Factory's methods return an abstract
 * product, while inside the method a concrete product is instantiated.
 */
class ConcreteFactory1: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA1()
    }
    
    func createProductB() -> AbstractProductB {
        return ConcreteProductB1()
    }
}

/**
 * Each concrete factory has a corresponding product variation.
 */
class ConcreteFactory2: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA2()
    }
    
    func createProductB() -> AbstractProductB {
        return ConcreteProductB2()
    }
}
