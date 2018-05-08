//
//  AF_Real_Factory.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

protocol UIFactory {
    
    /// Abstract factory interface
    
    func createAlert() -> Alert
    func snapshot(from alert: Alert) -> Snapshot
}

class MobileFactory: UIFactory {
    
    func createAlert() -> Alert {
        return MobileAlert()
    }
    
    func snapshot(from alert: Alert) -> Snapshot {
        /// take a screenshot from `alert.contentView` using
        /// iOS instruments
        return UIImage()
    }
}

class DesktopFactory: UIFactory {
    
    func createAlert() -> Alert {
        return DesktopAlert()
    }
    
    func snapshot(from alert: Alert) -> Snapshot {
        /// take a screenshot from `alert.contentView` using
        /// macOS instruments
        return UIImage() /* return NSImage in the macOS environment */
    }
}
