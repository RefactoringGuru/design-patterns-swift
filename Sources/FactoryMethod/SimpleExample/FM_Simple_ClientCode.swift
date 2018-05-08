//
//  FM_Simple_ClientCode.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class FactoryMethodTests_Simple: XCTestCase {
    
    func testFactoryMethod_Simple() {
        
        let info = "Very important info of the presentation"
        
        let clientCode = FactoryMethod_ClientCode()
        
        // Present info over WiFi
        clientCode.present(info: info, with: WifiFactory())
        
        // Present info over Bluetooth
        clientCode.present(info: info, with: BluetoothFactory())
    }
}

class FactoryMethod_ClientCode {
    
    private var currentProjector: Projector?
    
    func present(info: String, with factory: ProjectorFactory) {
        
        /// Check wheater a client code already present smth...
        
        guard let projector = currentProjector else {
            
            /// 'currentProjector' variable is nil.
            /// Create a new projector and start presentation.
            
            let projector = factory.createProjector()
            projector.present(info: info)
            self.currentProjector = projector
            return
        }
        
        /// Client code already has a projector.
        /// Let's sync pages of the old projector with a new one.
        
        self.currentProjector = factory.syncedProjector(with: projector)
        self.currentProjector?.present(info: info)
    }
}
