//
//  CompositeReal.swift
//  CompositeReal
//
//  Created by Maxim Eremenko on 6/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class CompositeRealExample: XCTestCase {
    ///TODO:
}

class SceneViewController: UIViewController {
    
    private lazy var drawer = Drawer(canvas: view)
    
    /// This action is triggered by a user.
    /// In this example, actions are triggered by a unit test externally.
    
    func userSelectedPointToDraw(point: CGPoint) {
        
    }
    
    func userSelectedConfigured(view: Component) {
        
    }
}

protocol Component {
    
    /// applies a prefix to a name of files and folders
    func apply(prefix: String)
    
    /// applies a suffix to a name of files and folders
    func apply(suffix: String)
    
//    func accept(visitor: )
    
    /// returns a size of files and folders
    var contentSize: Double { get }
}

protocol FilePreviewer {
    
}

protocol FolderPreviewer {
    
}

protocol ImageComponent {
    
    var isPicture: Bool { get }
    var picturesCount: Int { get }
}

protocol Shape {
    
    func attach(subviews: [UIView])
    func redraw()
}

extension UIView: Shape {
    
    func attach(subviews: [UIView]) {
        for item in subviews {
            addSubview(item)
        }
    }
    
    func redraw() {
        setNeedsDisplay()
    }
}

class Drawer {
    
    private var canvas: UIView
    
    init(canvas: UIView) {
        self.canvas = canvas
    }
}
