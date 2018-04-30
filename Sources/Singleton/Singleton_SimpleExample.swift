//
//  Singleton_SimpleExample.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 4/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class Singleton_SimpleExample: XCTestCase {
    
    func testSingletonSimple() {
        
        print(Defaults.shared)
    }
}

class Defaults {
    
    static var shared: Defaults = {
        let defaults = Defaults()
        
        // configure
        
        return defaults
    }()
    
    private init() {}
}
