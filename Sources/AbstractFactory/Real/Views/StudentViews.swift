//
//  AF_StudentViews.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

class StudentSignUpView: UIView, AuthView {

    private class StudentSignUpContentView: UIView {

        /// This view contains a number of features available
        /// only during a STUDENT authorization.
    }

    var contentView: UIView = StudentSignUpContentView()

    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthView.AuthAction?

    override var description: String {
        return "Student-SignUp-View"
    }
}

class StudentLoginView: UIView, AuthView {

    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let signUpButton = UIButton()

    var contentView: UIView {
        return self
    }

    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthView.AuthAction?

    override var description: String {
        return "Student-Login-View"
    }
}
