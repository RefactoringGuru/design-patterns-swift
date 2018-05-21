//
//  FM_Real_Factory.swift
//  Patterns for RefactoringGuru
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol ProjectorFactory {
    
    func createProjector() -> Projector
    
    func syncedProjector(with projector: Projector) -> Projector
}

extension ProjectorFactory {
    
    /// Base implementation of ProjectorFactory
    
    func syncedProjector(with projector: Projector) -> Projector {
        
        /// Every instance creates an own projector
        let newProjector = createProjector()
        
        /// sync projectors
        newProjector.sync(with: projector)
        
        return newProjector
    }
}

class WifiFactory: ProjectorFactory {
    
    func createProjector() -> Projector {
        return WifiProjector()
    }
}

class BluetoothFactory: ProjectorFactory {
    
    func createProjector() -> Projector {
        return BluetoothProjector()
    }
}
