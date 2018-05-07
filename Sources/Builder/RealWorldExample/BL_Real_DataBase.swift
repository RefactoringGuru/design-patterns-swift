//
//  BL_Real_DataBase.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol DomainModel {
    
}

struct User: DomainModel {
    let id: Int
    let age: Int
    let email: String
}

class DataBase {
    
    static var shared = DataBase()
}

extension DataBase {
    
    func fetch<Model: DomainModel>(query: Query<Model>) -> [Model] {
        
        guard var models = savedModels as? [Model] else { return [] }
        
        for item in query.operations {
            switch item.type {
            case .filter(let predicate):
                models = models.filter(predicate)
            case .limit(let limit):
                guard models.count > limit else { continue }
                models = Array(models[0..<limit])
            }
        }
        
        return models
    }
    
    private var savedModels: [DomainModel] {
        let user1 = User(id: 0, age: 10, email: "e1@email.com")
        let user2 = User(id: 1, age: 20, email: "e2@email.com")
        let user3 = User(id: 2, age: 30, email: "e3@email.com")
        let user4 = User(id: 3, age: 40, email: "e4@email.com")
        return [user1, user2, user3, user4]
    }
}
