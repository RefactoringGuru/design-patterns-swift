//
//  PT_Structure_Copying.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/// Coping using a custom Copying protocol

#if CompatibleWithXcode9_3

protocol Copying {
    
    init(original: Self)
    func copy() -> Self
}

extension Copying {
    
    func copy() -> Self {
        return Self.init(original: self)
    }
}

#endif
