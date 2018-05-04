//
//  ProjectorFactory.swift
//  Patterns for RefactoringGuru
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol ProjectorFactory {
    
    func createProjector() -> Projector
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
