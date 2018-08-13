//
//  SilencePolicy.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 8/10/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol NotificationPolicy: CustomStringConvertible {
    
    func isTurnedOn(for email: Email) -> Bool
    
    func isTurnedOn(for sms: SMS) -> Bool
    
    func isTurnedOn(for push: Push) -> Bool
}

class NightPolicyVisitor: NotificationPolicy {
    
    func isTurnedOn(for email: Email) -> Bool {
        return false
    }
    
    func isTurnedOn(for sms: SMS) -> Bool {
        return true
    }
    
    func isTurnedOn(for push: Push) -> Bool {
        return false
    }
    
    var description: String { return "Night Policy Visitor" }
}

class DefaultPolicyVisitor: NotificationPolicy {
    
    func isTurnedOn(for email: Email) -> Bool {
        return true
    }
    
    func isTurnedOn(for sms: SMS) -> Bool {
        return true
    }
    
    func isTurnedOn(for push: Push) -> Bool {
        return true
    }
    
    var description: String { return "Default Policy Visitor" }
}

class BlackListVisitor: NotificationPolicy {
    
    private var bannedEmails = [String]()
    private var bannedPhones = [String]()
    private var bannedUsernames = [String]()
    
    init(emails: [String], phones: [String], usernames: [String]) {
        self.bannedEmails = emails
        self.bannedPhones = phones
        self.bannedUsernames = usernames
    }
    
    func isTurnedOn(for email: Email) -> Bool {
        return bannedEmails.contains(email.emailOfSender)
    }
    
    func isTurnedOn(for sms: SMS) -> Bool {
        return bannedPhones.contains(sms.phoneNumberOfSender)
    }
    
    func isTurnedOn(for push: Push) -> Bool {
        return bannedUsernames.contains(push.usernameOfSender)
    }
    
    var description: String { return "Black List Visitor" }
}

