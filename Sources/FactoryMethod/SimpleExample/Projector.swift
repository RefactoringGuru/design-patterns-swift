//
//  Projector.swift
//  Patterns for RefactoringGuru
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol Projector {
    
    func present(info: String)
}

class WifiProjector: Projector {
    
    func present(info: String) {
        print("Presented over Wifi: \(info)")
    }
}

class BluetoothProjector: Projector {
    
    func present(info: String) {
        print("Presented over Bluetooth: \(info)")
    }
}
