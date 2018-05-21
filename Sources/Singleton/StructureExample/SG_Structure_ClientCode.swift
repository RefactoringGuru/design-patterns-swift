//
//  SG_Structure_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 4/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Singleton Design Pattern
///
/// Intent: Ensure that class has a single instance, and provide a global
/// point of access to it.

class SG_Structure_Example_Tests: XCTestCase {
    
    func testSingletonStructure() {
        
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared
        
        print(instance1.someBusinessLogic())
        print(instance2.someBusinessLogic())
        
        /// The instances are the same. Otherwise, the assert will fail.
        XCTAssert(instance1 === instance2)
    }
}

class Singleton {
    
    /// Static method, which controls access to singleton instance.
    ///
    /// This implementation allows creating singleton subclasses and having
    /// just one instance of each subclcass.
    
    static var shared: Singleton = {
        let instance = Singleton()
        // ...
        // configure
        // ...
        return instance
    }()
    
    /// Singleton initializer should always be private.
    
    private init() {}
    
    /// Singleton has some business logic, which can be executed on
    /// its instance.
    
    func someBusinessLogic() -> String {
        // ...
        return "Result of the 'someBusinessLogic' call"
    }
}

extension Singleton: NSCopying {
    
    /// Singletons should not be cloneable.
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
