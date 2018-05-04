//
//  FM_ClientCode_Real.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class FM_ClientCode_Real: XCTestCase {
    
    func testFactoryMethod_Real() {
        
        let authViewController = AuthViewController()
        
        // A user is a student
        let studentSignUpView = StudentAuthViewFactory.authView(for: .signUp)
        authViewController.present(authView: studentSignUpView)
        
        // A student has selected 'Log In' button
        let studentLoginView = StudentAuthViewFactory.authView(for: .login)
        authViewController.present(authView: studentLoginView)
        
        // A user is a teacher
        let teacherSignUpView = TeacherAuthViewFactory.authView(for: .signUp)
        authViewController.present(authView: teacherSignUpView)
        
        // A teacher has selected 'Log In' button
        let teacherLoginView = TeacherAuthViewFactory.authView(for: .login)
        authViewController.present(authView: teacherLoginView)
    }
}
