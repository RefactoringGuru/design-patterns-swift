//
//  PT_NSCopying_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 4/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Prototype Design Pattern
///
/// Intent: Specify the kinds of objects to create using a prototypical instance,
/// and create new objects by copying this prototype.

class PrototypeRealTests: XCTestCase {
    
    /// In Swift, objects can be copied by adopting
    /// NSCopying protocol or providing a custom implementation.
    
    func testPrototype_NSCopying() {
        
        let prototype = SubPrototype()
        prototype.update(intValue: 2, stringValue: "Value2")
        
        guard let anotherPrototype = prototype.copy() as? SubPrototype else {
            XCTAssert(false)
            return
        }
        
        XCTAssert(anotherPrototype == prototype)
        
        /// See implementation of 'Equatable' protocol for more details.
        print("Prototype is equal to the copied object!")
    }
}
