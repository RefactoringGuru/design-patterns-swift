//
//  BL_Simple_ClientCode.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BL_Simple_ClientCode_Tests: XCTestCase {
    
    func testSimpleBuilder() {
        
        /// This example shows how the client code can initialize properties
        let mac = MacBook(builder: {
            $0.name = "Super User"
            $0.color = .red
        })
        
        /// Simple builder
        let secondMac = MacBookBuilder()
            .with(name: "Second Mac")
            .with(color: .black)
        
        print(mac)
        print(secondMac)
    }
}

class MacBookBuilder {
    
    private var name: String?
    private var color: UIColor?
    
    func with(name: String) -> MacBookBuilder {
        self.name = name
        return self
    }
    
    func with(color: UIColor) -> MacBookBuilder {
        self.color = color
        return self
    }
    
    func build() -> MacBook {
        return MacBook(name: name, color: color)
    }
}

class MacBook {
    
    var name: String?
    var color: UIColor?
    
    typealias BuilderClosure = (MacBook) -> Void
    
    init(builder: BuilderClosure) {
        builder(self)
    }
    
    init(name: String?, color: UIColor?) {
        self.name = name
        self.color = color
    }
}
