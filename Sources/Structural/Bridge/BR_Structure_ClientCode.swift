//
//  BR_Structure_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/23/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Bridge Design Pattern
///
/// Intent: Decouple an abstraction from its implementation so that the two can
/// vary independently.
///
///              A
///           /     \                        A         N
///         Aa      Ab        ===>        /     \     / \
///        / \     /  \                 Aa(N) Ab(N)  1   2
///      Aa1 Aa2  Ab1 Ab2

class BR_Structure_ClientCode: XCTestCase {
    
    func testBridgeStructure() {
        
        /// The client code should be able to run with any pre-configured abstraction-
        /// implementation combination.
        
        let implementation = ConcreteImplementationA()
        clientCode(abstraction: Abstraction(implementation))
        
        let concreteImplementation = ConcreteImplementationB()
        clientCode(abstraction: ExtendedAbstraction(concreteImplementation))
    }
    
    /// Except for the initialization phase, where an Abstraction object gets linked
    /// with a specific Implementation object, the client code should only depend on
    /// the Abstraction class. This way the client code can support any abstraction-
    /// implementation combination.
    
    func clientCode(abstraction: Abstraction) {
        print(abstraction.operation())
    }
}

class Abstraction {
    /// The Abstraction defines the interface for the "control" part of the two class
    /// hierarchies. It maintains a reference to an object of the Implementation
    /// hierarchy and delegates it all of the real work.
    
    fileprivate var implementation: Implementation
    
    init(_ implementation: Implementation) {
        self.implementation = implementation
    }
    
    func operation() -> String {
        let operation = implementation.operationImplementation()
        return "Abstraction: Base operation with: " + operation
    }
}

class ExtendedAbstraction: Abstraction {
    /// You can extend the Abstraction without changing the Implementation classes.
    
    override func operation() -> String {
        let operation = implementation.operationImplementation()
        return "ExtendedAbstraction: Extended operation with: " + operation
    }
}

protocol Implementation {
    /// The Implementation defines the interface for all implementation classes. It
    /// doesn't have to match the Abstraction's interface. In fact, the two
    /// interfaces can be entirely different. Typically the Implementation interface
    /// provides only primitive operations, while the Abstraction defines higher-
    /// level operations based on those primitives.
    
    func operationImplementation() -> String
}

/// Each Concrete Implementation corresponds to a specific platform and
/// implements the Implementation interface using that platform's API.

class ConcreteImplementationA: Implementation {
    
    func operationImplementation() -> String {
        return "ConcreteImplementationA: The result in platform A"
    }
}

class ConcreteImplementationB: Implementation {
    
    func operationImplementation() -> String {
        return "ConcreteImplementationB: The result in platform B"
    }
}
