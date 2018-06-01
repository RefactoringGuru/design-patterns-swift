//
//  DecoratorStructuralExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Decorator Design Pattern
///
/// Intent: Attach additional responsibilities to an object dynamically.
/// Decorators provide a flexible alternative to subclassing for extending
/// functionality.

class DecoratorStructuralExample: XCTestCase {
    
    func testDecoratorStructure() {
        
        /// This way the client code can support both simple components...
        print("Client: I get a simple component")
        let simple = ConcreteComponent()
        clientCode(component: simple)
        
        /// ...as well as decorated ones.
            
        /// Note how decorators can wrap not only simple components but the other
        /// decorators as well.
        
        let decorator1 = ConcreteDecoratorA(simple)
        let decorator2 = ConcreteDecoratorB(decorator1)
        print("Client: Now I get a decorated component")
        clientCode(component: decorator2)
    }
    
    /// The client code works with all objects using the Component interface. This
    /// way it can stay independent of the concrete classes of components it works
    /// with.
    
    fileprivate func clientCode(component: Component) {
        print("Result: " + component.operation())
    }
}

/// The base Component interface defines operations that can be altered by
/// decorators.

private protocol Component {
    
    func operation() -> String
}

/// Concrete Components provide default implementations of the operations. There
/// might be several variations of these classes.

class ConcreteComponent: Component {
    
    func operation() -> String {
        return "ConcreteComponent"
    }
}

/// The base Decorator class follows the same interface as the other components.
/// The primary purpose of this class is to define the wrapping interface for all
/// concrete decorators. The default implementation of the wrapping code might
/// include a field for storing a wrapped component and the means to initialize
/// it.

private class Decorator: Component {
    
    private var component: Component
    
    init(_ component: Component) {
        self.component = component
    }
    
    /// The Decorator delegates all work to the wrapped component.
    func operation() -> String {
        return component.operation()
    }
}

/// Concrete Decorators call the wrapped object and alter its result in some way.

private class ConcreteDecoratorA: Decorator {
    
    /// Decorators may call parent implementation of the operation, instead of
    /// calling the wrapped object directly. This approach simplifies extension
    /// of decorator classes.
    
    override func operation() -> String {
        return "ConcreteDecoratorA(" + super.operation() + ")"
    }
}

/// Decorators can execute their behavior either before or after the call to a
/// wrapped object.

private class ConcreteDecoratorB: Decorator {
    
    override func operation() -> String {
        return "ConcreteDecoratorB(" + super.operation() + ")"
    }
}
