//
//  VisitorReal.swift
//  VisitorReal
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class VisitorRealExample: XCTestCase {
    
    func test() {
        
        let email = Email(emailOfSender: "some@email.com")
        let sms = SMS(phoneNumberOfSender: "+3806700000")
        let push = Push(usernameOfSender: "Spammer")
        
        let notifications: [Notification] = [email, sms, push]
        
        let blackList = createBlackList()
        
        clientCode(handle: notifications, with: DefaultPolicyVisitor(), and: blackList)
        
        clientCode(handle: notifications, with: NightPolicyVisitor(), and: blackList)
    }
    
    func clientCode(handle notifications: [Notification],
                    with policy: SilencePolicy,
                    and blackList: BlackList) {
        
        print("\nClient: Using \(policy.description):")
        
        notifications.forEach { item in
            
            guard !item.isSenderBanned(by: blackList) else {
                print("\tWARNING: " + item.description + " is in a black list")
                return
            }
            
            if item.isNotificationTurnedOn(for: policy) {
                print("\t" + item.description + " notification will be shown")
            } else {
                print("\t" + item.description + " notification will be silenced")
            }
        }
    }
    
    private func createBlackList() -> BlackListVisitor {
        return BlackListVisitor(emails: ["banned@email.com"],
                                phones: ["000000000", "1234325232"],
                                usernames: ["Spammer"])
    }
}
