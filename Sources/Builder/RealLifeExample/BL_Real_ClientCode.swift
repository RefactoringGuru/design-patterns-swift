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
        clientCode(builder: RealmQueryBuilder<User>())
        clientCode(builder: CoreDataQueryBuilder<User>())
    }
    
    func clientCode(builder: BaseQueryBuilder<RealmOperationType<User>>) {
        
        let query = builder.filter({ $0.age < 20 })
            .limit(1)
            .query
        
        _ = RealmDataProvider().fetch(query: query)
    }
    
    func clientCode(builder: BaseQueryBuilder<CoreDataOperationType<User>>) {
        
        let query = builder.filter({ $0.age < 20 })
            .limit(1)
            .query
        
        _ = CoreDataProvider().fetch(query: query)
    }
}
