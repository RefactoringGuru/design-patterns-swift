//
//  AF_AuthView.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

protocol AuthView {
    
    typealias AuthAction = (AuthType) -> ()
    
    var contentView: UIView { get }
    var authHandler: AuthAction? { get set }
    
    var description: String { get }
}
