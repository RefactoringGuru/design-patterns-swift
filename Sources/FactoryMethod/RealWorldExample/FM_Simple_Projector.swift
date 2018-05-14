//
//  FM_Simple_Projector.swift
//  Patterns for RefactoringGuru
//
//  Created by Maxim Eremenko on 4/19/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol Projector {
    
    /// Abstract projector interface
    
    var currentPage: Int { get }
    
    func present(info: String)
    
    func sync(with projector: Projector)
    
    func update(with page: Int)
}

extension Projector {
    
    /// Base implementation of Projector methods
    
    func sync(with projector: Projector) {
        projector.update(with: currentPage)
    }
}

class WifiProjector: Projector {
    
    var currentPage = 0
    
    func present(info: String) {
        print("Info is presented over Wifi: \(info)")
    }
    
    func update(with page: Int) {
        /// ...
        /// scroll page via WiFi connection
        /// ...
        currentPage = page
    }
}

class BluetoothProjector: Projector {
    
    var currentPage = 0
    
    func present(info: String) {
        print("Info is presented over Bluetooth: \(info)")
    }
    
    func update(with page: Int) {
        /// ...
        /// scroll page via Bluetooth connection
        /// ...
        currentPage = page
    }
}
