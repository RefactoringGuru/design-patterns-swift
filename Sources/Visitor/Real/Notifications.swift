//
//  Notifications.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 8/10/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol Notification: CustomStringConvertible {
    
    func accept(visitor: NotificationPolicy) -> Bool
}

struct Email {
    
    let emailOfSender: String
    
    var description: String { return "Email" }
}

struct SMS {
    
    let phoneNumberOfSender: String
    
    var description: String { return "SMS" }
}

struct Push {
    
    let usernameOfSender: String
    
    var description: String { return "Push" }
}

extension Email: Notification {
    
    func accept(visitor: NotificationPolicy) -> Bool {
        return visitor.isTurnedOn(for: self)
    }
}

extension SMS: Notification {
    
    func accept(visitor: NotificationPolicy) -> Bool {
        return visitor.isTurnedOn(for: self)
    }
}

extension Push: Notification {
    
    func accept(visitor: NotificationPolicy) -> Bool {
        return visitor.isTurnedOn(for: self)
    }
}
