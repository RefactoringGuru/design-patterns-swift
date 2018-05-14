//
//  AuthViewController.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    fileprivate var contentView: AuthView
    
    init(contentView: AuthView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        return nil
    }
}

class StudentAuthViewController: AuthViewController {
    
    /// Student-oriented features
}

class TeacherAuthViewController: AuthViewController {
    
    /// Teacher-oriented features
}
