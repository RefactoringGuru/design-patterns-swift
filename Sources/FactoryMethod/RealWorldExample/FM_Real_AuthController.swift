//
//  AuthViewController.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authContentView: AuthView?
    
    func present(authView: AuthView, animated: Bool = true) {
        if animated {
            // Presentaiton with an animation
        }
        self.authContentView = authView
        
        print("Presented: \(authView.description)")
    }
}
