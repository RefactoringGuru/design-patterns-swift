//
//  BlackList.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 8/10/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol BlackList: CustomStringConvertible {
    
    func inBlackList(email: Email) -> Bool
    
    func inBlackList(sms: SMS) -> Bool
    
    func inBlackList(push: Push) -> Bool
}

class BlackListVisitor: BlackList {
    
    private var bannedEmails = [String]()
    private var bannedPhones = [String]()
    private var bannedUsernames = [String]()
    
    init(emails: [String], phones: [String], usernames: [String]) {
        self.bannedEmails = emails
        self.bannedPhones = phones
        self.bannedUsernames = usernames
    }
    
    func inBlackList(email: Email) -> Bool {
        return bannedEmails.contains(email.emailOfSender)
    }
    
    func inBlackList(sms: SMS) -> Bool {
        return bannedPhones.contains(sms.phoneNumberOfSender)
    }
    
    func inBlackList(push: Push) -> Bool {
        return bannedUsernames.contains(push.usernameOfSender)
    }
    
    var description: String { return "Black List Visitor" }
}
