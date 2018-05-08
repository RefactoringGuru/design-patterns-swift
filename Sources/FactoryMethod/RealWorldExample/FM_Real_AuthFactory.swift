//
//  AuthFactory.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

enum AuthType {
    case login
    case signUp
}

protocol AuthViewFactory {
    
    static func authView(for type: AuthType) -> AuthView
}

class StudentAuthViewFactory: AuthViewFactory {
    
    static func authView(for type: AuthType) -> AuthView {
        switch type {
            case .login: return StudentLoginView()
            case .signUp: return StudentSignUpView()
        }
    }
}

class TeacherAuthViewFactory: AuthViewFactory {
    
    static func authView(for type: AuthType) -> AuthView {
        switch type {
            case .login: return TeacherLoginView()
            case .signUp: return TeacherSignUpView()
        }
    }
}
