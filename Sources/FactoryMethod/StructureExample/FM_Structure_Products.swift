//
//  FM_Structure_Products.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/**
 * Define the interface of objects the factory method creates.
 */

protocol Product {
    
    func operation() -> String
}

/**
 * Implement the Product interface.
 */

class ConcreteProduct1: Product {
    
    func operation() -> String {
        return "Result of ConcreteProduct1"
    }
}

/**
 * Implement the Product interface.
 */

class ConcreteProduct2: Product {
    
    func operation() -> String {
        return "Result of ConcreteProduct2"
    }
}
