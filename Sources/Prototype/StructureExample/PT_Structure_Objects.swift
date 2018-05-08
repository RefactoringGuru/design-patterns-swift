//
//  PT_Structure_Objects.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

struct Wheel {
    
    var size: Int
}

class Vehicle: Copying {
    
    var name: String
    var wheels: [Wheel]
    
    required init(original: Vehicle) {
        self.name = original.name
        self.wheels = original.wheels
    }
    
    init(name: String, wheels: [Wheel]) {
        self.name = name
        self.wheels = wheels
    }
}

class Car: Vehicle {
    
    var color: UIColor
    
    init(color: UIColor) {
        
        /// Set up car with defaults.
        let wheels = [Wheel(size: 14), Wheel(size: 14),
                      Wheel(size: 14), Wheel(size: 14)]
        self.color = color
        super.init(name: "Car", wheels: wheels)
    }
    
    required init(original: Vehicle) {
        
        /// Swift does not allow to override constructor
        /// of the parent class with a 'Car' instead of 'Vehicle'.
        ///
        /// Let us know if you have any other solutions for this case.
        
        if let car = original as? Car {
            self.color = car.color
        } else {
            /// Otherwise, set a default value.
            self.color = .clear
        }
        super.init(original: original)
    }
}
