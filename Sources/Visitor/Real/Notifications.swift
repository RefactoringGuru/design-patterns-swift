//
//  Notifications.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 8/10/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol Notification: CustomStringConvertible {
    
    func isNotificationTurnedOn(for policy: SilencePolicy) -> Bool
    
    func isSenderBanned(by policy: BlackList) -> Bool
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
    
    func isNotificationTurnedOn(for policy: SilencePolicy) -> Bool {
        return policy.isEmailTurnedOn
    }
    
    func isSenderBanned(by policy: BlackList) -> Bool {
        return policy.inBlackList(email: self)
    }
}

extension SMS: Notification {
    
    func isNotificationTurnedOn(for policy: SilencePolicy) -> Bool {
        return policy.isSMSTurnedOn
    }
    
    func isSenderBanned(by policy: BlackList) -> Bool {
        return policy.inBlackList(sms: self)
    }
}

extension Push: Notification {
    
    func isNotificationTurnedOn(for policy: SilencePolicy) -> Bool {
        return policy.isPushTurnedOn
    }
    
    func isSenderBanned(by policy: BlackList) -> Bool {
        return policy.inBlackList(push: self)
    }
}
