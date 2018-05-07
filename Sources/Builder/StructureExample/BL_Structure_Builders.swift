//
//  BL_Structure_Builders.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/**
 * Base Builder interface specifies operations for creating parts of a
 * Product object.
 */

protocol Builder {
    
    func producePartA()
    func producePartB()
    func producePartC()
}

/**
 * Concrete Builders implement the common Builder interface and provide specific
 * implementations of the building steps. Program may have several Builder
 * variations with different implementations.
 */
class ConcreteBuilder1: Builder
{
    private var product = Product1()
    
    /**
     * New builder already contains a blank product that will be used in
     * further assembly.
     */
    
    func reset() {
        product = Product1()
    }
    
    /**
     * All production steps work with the same product instance.
     */
    
    func producePartA() {
        product.add(part: "PartA1")
    }
    
    func producePartB() {
        product.add(part: "PartB1")
    }
    
    func producePartC() {
        product.add(part: "PartC1")
    }
    
    /**
     * Provide an interface for retrieving the product. Builders may create
     * different product types. That's why this method is not defined in base
     * interface.
     *
     * Once product is completed, prepare a blank product object so that new
     * product could be built.
     */
    
    func retrieveProduct() -> Product1 {
        let result = self.product
        reset()
        return result
    }
}
