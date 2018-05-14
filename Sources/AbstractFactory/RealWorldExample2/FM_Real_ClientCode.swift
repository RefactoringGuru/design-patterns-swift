//
//  FM_Real_ClientCode.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 4/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class FM_ClientCode_Real: XCTestCase {
    
    func testFactoryMethod_Real() {
                
        #if teacherMode
            let clientCode = ClientCode(factoryType: StudentAuthViewFactory.self)
        #else
            let clientCode = ClientCode(factoryType: TeacherAuthViewFactory.self)
        #endif
        
        /// Present LogIn flow
        clientCode.presentLogin()
        
        /// Present SignUp flow
        clientCode.presentSignUp()
    }
}

private class ClientCode {
    
    private var currentController: AuthViewController?
    
    private lazy var navigationController: UINavigationController = {
        guard let vc = currentController else { return UINavigationController() }
        return UINavigationController(rootViewController: vc)
    }()
    
    private let factoryType: AuthViewFactory.Type
    
    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }
    
    //MARK: - Presentation
    
    func presentLogin() {
        let controller = factoryType.authController(for: .login)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSignUp() {
        let controller = factoryType.authController(for: .signUp)
        navigationController.pushViewController(controller, animated: true)
    }
    
    /// Other methods...
}
