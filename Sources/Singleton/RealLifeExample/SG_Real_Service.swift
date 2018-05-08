//
//  SG_Real_Service.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/8/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

class FriendsChatService: MessageService {
    
    static let shared = FriendsChatService()
    
    private var subscribers = [MessageSubscriber]()
    
    private init() {
        startFetching()
    }
    
    func add(subscriber: MessageSubscriber) {
        subscribers.append(subscriber)
    }
    
    func startFetching() {
        
        /// Set up network stack, establish a connection...
        /// ...and retrieve data from a server
        
        let newMessages = [Message(id: 0, text: "Text0"),
                           Message(id: 5, text: "Text5"),
                           Message(id: 10, text: "Text10")]
        
        let removedMessages = [Message(id: 1, text: "Text0")]
        
        /// Send updated data to subscribers
        receivedNew(messages: newMessages)
        receivedRemoved(messages: removedMessages)
    }
}

private extension FriendsChatService {
    
    func receivedNew(messages: [Message]) {
        
        subscribers.forEach { item in
            item.accept(new: messages)
        }
    }
    
    func receivedRemoved(messages: [Message]) {
        
        subscribers.forEach { item in
            item.accept(removed: messages)
        }
    }
}
