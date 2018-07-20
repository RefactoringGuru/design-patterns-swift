//
//  Request.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 7/21/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol Request {
    
    var firstName: String? { get }
    var lastName: String? { get }
    
    var email: String? { get }
    var password: String? { get }
    var repeatedPassword: String? { get }
}

extension Request {
    
    /// Default implementations
    
    var firstName: String? { return nil }
    var lastName: String? { return nil }
    
    var email: String? { return nil }
    var password: String? { return nil }
    var repeatedPassword: String? { return nil }
}

struct SignUpRequest: Request {
    
    var firstName: String?
    var lastName: String?
    
    var email: String?
    var password: String?
    var repeatedPassword: String?
}

struct LoginRequest: Request {
    
    var email: String?
    var password: String?
}
