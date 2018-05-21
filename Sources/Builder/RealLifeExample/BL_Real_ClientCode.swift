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
        
        let query = RealmQueryBuilder<User>()
            .filter({ $0.age > 18 })
            .limit(2)
            .query
        
        let coreDataQuery = CoreDataQueryBuilder<User>()
            .filter({ $0.age < 20 })
            .limit(1)
            .query
        
        _ = RealmDataProvider().fetch(query: query)
        _ = CoreDataProvider().fetch(query: coreDataQuery)
    }
}
