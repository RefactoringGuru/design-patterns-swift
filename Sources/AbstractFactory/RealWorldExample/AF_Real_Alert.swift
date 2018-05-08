//
//  AF_Real_Alert.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

protocol Alert {
    
    /// Abstract (cross-platform) protocol of the alert
    
    func show(with title: String)
    
    var contentView: ContentView { get }
}

class MobileAlert: Alert {
    
    var contentView: ContentView = UIView()
    
    func show(with title: String) {
        /// present using UIAlertController
    }
}

class DesktopAlert: Alert {
    
    /// NSView should be used in macOS environment
    var contentView: ContentView = UIView()
    
    func show(with title: String) {
        /// present using NSAlert
    }
}

protocol ContentView {
    /// Abstract content view.
    /// Implementation depends on the platform
}

protocol Snapshot {
    /// Abstract snapshot image.
    /// Implementation depends on the platform
}

/// This extension should be added in macOS environment
/// extension NSView: ContentView {}
extension UIView: ContentView {}

/// This extension should be added in macOS environment
/// extension NSImage: Snapshot {}
extension UIImage: Snapshot {}
