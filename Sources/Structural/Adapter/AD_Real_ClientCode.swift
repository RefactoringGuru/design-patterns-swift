//
//  AD_Real_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/23/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest
import UIKit

/// Adapter Design Pattern
///
/// Intent: Convert the interface of a class into the interface clients expect.
/// Adapter lets classes work together that couldn't work otherwise because of
/// incompatible interfaces.

class AD_Real_ClientCode: XCTestCase {
    
    /// Example.
    /// Let's assume that our app perfectly works with Facebook authorization.
    /// However, users ask you to add sign in via Twitter.
    ///
    /// Unfortunately, Twitter SDK has a different authorization method.
    ///
    /// Firstly, you have to create the new protocol 'AuthService'
    /// and insert the authorization method of Facebook SDK.
    ///
    /// Secondly, write an extension for Twitter SDK and implement methods
    /// of AuthService protocol, just a simple redirect.
    ///
    /// Thirdly, write an extension for Facebook SDK.
    /// You should not write any code at this point as methods
    /// already implemented by Facebook SDK.
    ///
    /// It just tells a compiler that both SDKs have the same interface.
    
    func testAdapterReal() {
        startAuthorization(with: FacebookAuthSDK())
        startAuthorization(with: TwitterAuthSDK())
    }
    
    func startAuthorization(with service: AuthService) {
        
        /// The current top view controller of the app
        let topViewController = UIViewController()
        
        service.presentAuthFlow(from: topViewController)
    }
}

protocol AuthService {
    
    func presentAuthFlow(from viewController: UIViewController)
}

class FacebookAuthSDK {
    
    func presentAuthFlow(from viewController: UIViewController) {
        /// Call SDK methods and pass a view controller
    }
}

class TwitterAuthSDK {
    
    func startAuthorization(with viewController: UIViewController) {
        /// Call SDK methods and pass a view controller
    }
}

extension TwitterAuthSDK: AuthService {
    
    /// This is an adapter
    ///
    /// Yeah, we are able to not create another class
    /// and just extend an existing one
    
    func presentAuthFlow(from viewController: UIViewController) {
        self.startAuthorization(with: viewController)
    }
}

extension FacebookAuthSDK: AuthService {
    /// This extension just tells a compiler
    /// that both SDKs have the same interface.
}
