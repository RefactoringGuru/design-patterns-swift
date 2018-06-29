//
//  CompositeReal.swift
//  CompositeReal
//
//  Created by Maxim Eremenko on 6/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class CompositeRealExample: XCTestCase {
    
    func test() {
        
        print("\nClient: Applying 'default' theme for 'UIButton'")
        apply(theme: DefaultButtomTheme(), for: UIButton())
        
        print("\nClient: Applying 'night' theme for 'UIButton'")
        apply(theme: NightButtonTheme(), for: UIButton())
        
        print("\nClient: Let's use View Controller as a composite!")
        
        print("\nClient: Applying 'night button' theme for 'WelcomeViewController'...")
        apply(theme: NightButtonTheme(), for: WelcomeViewController())
        print()
    }
    
    func apply<T: Theme>(theme: T, for component: Component) {
        component.accept(theme: theme)
    }
}

class WelcomeViewController: UIViewController {
    
    class ContentView: UIView {
        
        var titleLabel = UILabel()
        var actionButton = UIButton()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder decoder: NSCoder) {
            super.init(coder: decoder)
            setup()
        }
        
        func setup() {
            addSubview(titleLabel)
            addSubview(actionButton)
        }
    }
    
    override func loadView() {
        view = ContentView()
    }
}

/// Let's override a description property for the better output

extension WelcomeViewController {
    
    open override var description: String { return "WelcomeViewController" }
}

extension WelcomeViewController.ContentView {
    
    override var description: String { return "ContentView" }
}

extension UIButton {
    
    open override var description: String { return "UIButton" }
}

extension UILabel {
    
    open override var description: String { return "UILabel" }
}
