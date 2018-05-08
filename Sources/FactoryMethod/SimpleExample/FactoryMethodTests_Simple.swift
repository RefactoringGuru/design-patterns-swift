//
//  FactoryMethodTests.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class FactoryMethodTests_Simple: XCTestCase {
    
    func testFactoryMethod() {
        
        let info = "Very important info of our presentation"
        
        let factory = projectorFactory(isInternetAvailable: true)
        let projector = factory.createProjector()
        projector.present(info: info)
        
        // Oooops.... an internet connection was lost
        let anotherFactory = projectorFactory(isInternetAvailable: false)
        let anotherProjector = anotherFactory.createProjector()
        anotherProjector.present(info: info)
    }
    
    func projectorFactory(isInternetAvailable: Bool) -> ProjectorFactory {
        return isInternetAvailable ? WifiFactory() : BluetoothFactory()
    }
}
