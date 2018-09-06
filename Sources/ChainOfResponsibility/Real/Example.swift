//
//  ChainOfResponsibilityReal.swift
//  ChainOfResponsibilityReal
//
//  Created by Maxim Eremenko on 7/11/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class ChainOfResponsibilityRealExample: XCTestCase {

    func test() {

        print("Client: Let's test Login flow!")

        let loginHandler = LoginHandler(with: LocationHandler())
        let loginController = LoginViewController(handler: loginHandler)

        loginController.loginButtonSelected()

        print("\nClient: Let's test SignUp flow!")

        let signUpHandler = SignUpHandler(with: LocationHandler(with: NotificationHandler()))
        let signUpController = SignUpViewController(handler: signUpHandler)

        signUpController.signUpButtonSelected()
    }
}
