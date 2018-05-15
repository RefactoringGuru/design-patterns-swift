//
//  AF_Real_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class AF_Real_ClientCode_Tests: XCTestCase {
    
    func testAbstractFactory_Real() {
        
        #if os(iOS)
            let factory = MobileFactory()
        #elseif os(macOS)
            let factory = DesktopFactory()
        #endif
        
        /// Creation and presentation of the alert
        let alert = factory.createAlert()
        alert.show(with: "Mobile Alert")
        
        /// Taking and printing a snapshot of the alert
        let snapshot = factory.snapshot(from: alert)
        print(snapshot)
    }
}
