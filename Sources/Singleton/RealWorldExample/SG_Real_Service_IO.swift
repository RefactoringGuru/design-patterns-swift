//
//  SG_Real_Service_IO.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/// Protocol for call-back events

protocol MessageSubscriber {
    
    func accept(new messages: [Message])
    func accept(removed messages: [Message])
}

/// Protocol for communication with a message service

protocol MessageService {
    
    func add(subscriber: MessageSubscriber)
}

/// Message domain model

struct Message {
    
    let id: Int
    let text: String
}
