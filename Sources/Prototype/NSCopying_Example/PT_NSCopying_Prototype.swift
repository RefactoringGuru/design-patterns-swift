//
//  PT_NSCopying_Prototype.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/// Coping using NSCopying

class Prototype: NSCopying, Equatable {
    
    private var intValue = 1
    private var stringValue = "Value"
    
    required init() {}
    
    func update(intValue: Int = 1, stringValue: String = "Value") {
        self.intValue = intValue
        self.stringValue = stringValue
    }
    
    /// MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        
        let prototype = type(of: self).init()
        prototype.intValue = intValue
        prototype.stringValue = stringValue
        return prototype
    }
    
    /// MARK: - Equatable
    static func == (lhs: Prototype, rhs: Prototype) -> Bool {
        return lhs.intValue == rhs.intValue && lhs.stringValue == rhs.stringValue
    }
}

class SubPrototype: Prototype {
    
    private var boolValue = true
    
    func copy() -> Any {
        return copy(with: nil)
    }
    
    override func copy(with zone: NSZone?) -> Any {
        guard let prototype = super.copy(with: zone) as? SubPrototype else {
            return SubPrototype() // smth went wrong
        }
        prototype.boolValue = boolValue
        return prototype
    }
}
