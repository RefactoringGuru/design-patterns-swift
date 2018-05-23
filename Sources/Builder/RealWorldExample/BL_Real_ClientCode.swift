//
//  BL_Real_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BL_Real_ClientCode_Tests: XCTestCase {
    
    func testRealBuilder() {
        print("Start fetching data from Realm")
        clientCode(builder: RealmQueryBuilder<User>())
        
        print("Start fetching data from CoreData")
        clientCode(builder: CoreDataQueryBuilder<User>())
    }
    
    func clientCode(builder: RealmQueryBuilder<User>) {
        
        let results = builder.filter({ $0.age < 20 })
            .limit(1)
            .fetch()
        
        print("We have fetched: " + String(results.count) + " from Realm")
    }
    
    func clientCode(builder: CoreDataQueryBuilder<User>) {
        
        let results = builder.filter({ $0.age > 18 })
            .limit(2)
            .fetch()
        
        print("We have fetched: " + String(results.count) + " from CoreData")
    }
}

protocol DomainModel {
    /// The protocol groups domain models to the common interface
}

struct User: DomainModel {
    let id: Int
    let age: Int
    let email: String
}
