//
//  BL_Structure_Products.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/**
 * Product class represents a complex object under construction.
 *
 * Unlike in other creational patterns, different builders can produce
 * unrelated products. In other words, products of different Builders don't need
 * to follow a common interface.
 */
class Product1
{
    // LinkedList can be used for the efficient insertion and saving the order
    private var parts = [String]()
    
    func add(part: String) {
        self.parts.append(part)
    }
    
    func listParts() -> String {
        return "Product parts: " + parts.flatMap({ $0 + "," }) + "\n\n"
    }
}
