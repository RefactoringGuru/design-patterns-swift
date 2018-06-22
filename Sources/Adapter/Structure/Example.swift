//
//  ADStructuralExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// Adapter Design Pattern
///
/// Intent: Convert the interface of a class into the interface clients expect.
/// Adapter lets classes work together that couldn't work otherwise because of
/// incompatible interfaces.

class AdapterStructuralExample: XCTestCase {
    
    func testAdapterStructure() {
        
        print("Client: I can work just fine with the Target objects:")
        clientCode(target: Target())
        
        let adaptee = Adaptee()
        print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
        print(adaptee.specificRequest())
        
        print("Client: But I can work with it via the Adapter:")
        clientCode(target: Adapter(adaptee))
    }
    
    fileprivate func clientCode(target: Target) {
        /// The client code supports all classes that follow the Target interface.
        print(target.request())
    }
}

private class Target {
    /// The Target defines the domain-specific interface used by the client code.
    
    func request() -> String {
        return "Target: The default target's behavior."
    }
}

private class Adaptee {
    
}

extension Adaptee {
    /// The Adaptee contains some useful behavior, but its interface is incompatible
    /// with the existing client code. The Adaptee needs some adaptation before the
    /// client code can use it.
    
    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
    }
}

private class Adapter: Target {
    /// The Adapter makes the Adaptee's interface compatible with the Target's
    /// interface.
    
    private var adaptee: Adaptee
    
    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    override func request() -> String {
        return "Adapter: (TRANSLATED) " + adaptee.specificRequest().reversed()
    }
}
