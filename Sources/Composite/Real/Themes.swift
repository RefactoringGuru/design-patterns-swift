//
//  Themes.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 6/29/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

protocol Theme: CustomStringConvertible {
    
    var backgroundColor: UIColor { get }
}

protocol ButtomTheme: Theme {
    
    var textColor: UIColor { get }
    
    var highlightedColor: UIColor { get }
    
    /// other properties
}

protocol LabelTheme: Theme {
    
    var textColor: UIColor { get }
    
    /// other properties
}

/// Button Themes

struct DefaultButtomTheme: ButtomTheme {
    
    var textColor = UIColor.red
    
    var highlightedColor = UIColor.white
    
    var backgroundColor = UIColor.orange
    
    var description: String { return "Default Buttom Theme" }
}

struct NightButtonTheme: ButtomTheme {
    
    var textColor = UIColor.white
    
    var highlightedColor = UIColor.red
    
    var backgroundColor = UIColor.black
    
    var description: String { return "Night Buttom Theme" }
}

/// Label Themes

struct DefaultLabelTheme: LabelTheme {
    
    var textColor = UIColor.red
    
    var backgroundColor = UIColor.black
    
    var description: String { return "Default Label Theme" }
}

struct NightLabelTheme: LabelTheme {
    
    var textColor = UIColor.white
    
    var backgroundColor = UIColor.black
    
    var description: String { return "Night Label Theme" }
}

