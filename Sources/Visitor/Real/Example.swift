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
        
        let notifications: [Notification] = [Email(), SMS(), Push()]
        
        clientCode(handle: notifications, with: DefaultPolicy())
        
        clientCode(handle: notifications, with: NightPolicy())
    }
    
    func clientCode(handle notifications: [Notification], with policy: NotificationPolicy) {
        print("\nClient: Using \(policy.description):")
        
        notifications.forEach { item in
            if item.isNotificationOn(for: policy) {
                print("\t" + item.description + " notification will be shown")
            } else {
                print("\t" + item.description + " notification will be silenced")
            }
        }
    }
}

/// Policy

protocol NotificationPolicy: CustomStringConvertible {
    
    var isEmailOn: Bool { get }
    var isSMSOn: Bool { get }
    var isPushOn: Bool { get }
}

class NightPolicy: NotificationPolicy {
    
    var isEmailOn: Bool { return false }
    
    var isSMSOn: Bool { return true }
    
    var isPushOn: Bool { return false }
    
    var description: String { return "Night Policy" }
}

class DefaultPolicy: NotificationPolicy {
    
    var isEmailOn: Bool { return true }
    
    var isSMSOn: Bool { return true }
    
    var isPushOn: Bool { return true }
    
    var description: String { return "Default Policy" }
}

/// Notifications

protocol Notification: CustomStringConvertible {
    
    func isNotificationOn(for policy: NotificationPolicy) -> Bool
}

struct Email: Notification {
    
    func isNotificationOn(for policy: NotificationPolicy) -> Bool {
        return policy.isEmailOn
    }
    
    var description: String { return "Email" }
}

struct SMS: Notification {
    
    func isNotificationOn(for policy: NotificationPolicy) -> Bool {
        return policy.isSMSOn
    }
    
    var description: String { return "SMS" }
}

struct Push: Notification {
    
    func isNotificationOn(for policy: NotificationPolicy) -> Bool {
        return policy.isPushOn
    }
    
    var description: String { return "Push" }
}
