//
//  CompositeStructureExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Composite Design Pattern
///
/// Intent: Compose objects into tree structures to represent part-whole
/// hierarchies. Composite lets clients treat individual objects and compositions
/// of objects uniformly.

class CompositeStructureExample: XCTestCase {
    
    func testCompositeStructure() {
        
        /// This way the client code can support the simple leaf components...
        print("Client: Using a simple component")
        clientCode(component: Leaf())
        
        /// ...as well as the complex composites.
        let tree = Composite()
        
        let branch1 = Composite()
        branch1.add(component: Leaf())
        branch1.add(component: Leaf())
        
        let branch2 = Composite()
        branch2.add(component: Leaf())
        branch2.add(component: Leaf())
        
        tree.add(component: branch1)
        tree.add(component: branch2)
        
        print("Client: Now I get a composite tree")
        clientCode(component: tree)
        
        print("Two components can be merged without checking their classes")
        clientCode2(leftComponent: tree, rightComponent: Leaf())
    }
    
    /// The client code works with all of the components via the base interface.
    fileprivate func clientCode(component: Component) {
        print("Results: " + component.operation())
    }
    
    fileprivate func clientCode2(leftComponent: Component, rightComponent: Component) {
        
        /// Thanks to the fact that the child-management operations declared in the Base
        /// Component class, the client code can work with any component, simple or
        /// complex, without depending on their concrete classes.
        
        if leftComponent.isComposite {
            leftComponent.add(component: rightComponent)
        }
        
        print("Results: " + leftComponent.operation())
    }
}

/// The Base Component class declares common operations for both simple and
/// complex objects of a composition.

private protocol Component {
    
    /// Optionally, the base Component can declare an interface for setting and
    /// accessing a parent of the component in a tree structure. It can also
    /// provide some default implementation for these methods.
    
    var parent: Component? { get set }
    
    /// The Base Component may implement some default behavior or leave it to
    /// concrete classes (by declaring "abstract" the method containing the
    /// behavior).
    
    func operation() -> String
    
    /// In some cases, it would be beneficial to define the child-management
    /// operations right in the Base Component class. This way, you won't need to
    /// expose any concrete component classes to the client code, even during the
    /// object tree assembly. The downside is that these methods will be empty
    /// for the leaf-level components.
    
    func add(component: Component)
    
    /// You can provide a method that lets the client code figure out whether a
    /// component can bear children.
    
    var isComposite: Bool { get }
}

private extension Component {
    
    func add(component: Component) {}
}

/// The Leaf class represents the end objects of a composition. A leaf can't have
/// any children.

/// Usually, it's the Leaf objects that do the actual work, whereas Composite
/// objects only delegate to their sub-components.

private class Leaf: Component {
    
    var parent: Component?
    
    var isComposite: Bool {
        return false
    }
    
    
    func operation() -> String {
        return "Leaf"
    }
}

/// The Composite class represents the complex components that may have children.
/// Usually, the Composite objects delegate the actual work to their children and
/// then "sum-up" the result.

private class Composite: Component {
    
    private var children = [Component]()
    
    /// A composite object can add or remove other components (both simple or
    /// complex) to or from its child list.
    
    func add(component: Component) {
        var item = component
        item.parent = self
        children.append(item)
    }
    
    var parent: Component?
    
    var isComposite: Bool {
        return true
    }
    
    /// The Composite executes the primary component's logic in a particular way.
    /// It traverses recursively through all its children, collects and sums-up
    /// their results. Since composite's children pass these calls to their
    /// children and so forth, the whole object tree is traversed as a result.
    
    func operation() -> String {
        
        let result = children.map({ $0.operation() }).joined(separator: " ")
        return "\n\tBranch(" + result + ")"
    }
}
