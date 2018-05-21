//
//  BL_Structure_Directors.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

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
