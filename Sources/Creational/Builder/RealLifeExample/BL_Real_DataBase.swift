//
//  BL_Real_DataBase.swift
//  RefactoringGuru.Patterns
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

class RealmDataProvider {
    
    func fetch<Model: DomainModel>(query: Query<RealmOperationType<Model>>) -> [Model] {
        
        for item in query.operations {
            switch item {
            case .filter(_):
                /// Use Realm instance to filter results
                break
            case .limit(_):
                /// Use Realm instance to limit results
                break
            }
        }
        
        /// Return results from Realm
        return []
    }
}

class CoreDataProvider {
    
    func fetch<Model: DomainModel>(query: Query<CoreDataOperationType<Model>>) -> [Model] {
        
        /// Create a NSFetchRequest
        
        for item in query.operations {
            switch item {
            case .filter(_):
                /// Set a 'predicate' for a NSFetchRequest
                break
            case .limit(_):
                /// Set a 'fetchLimit' for a NSFetchRequest
                break
            case .includesPropertyValues(_):
                /// Set an 'includesPropertyValues' for a NSFetchRequest
                break
            }
        }
        
        /// Execute a NSFetchRequest and return results
        return []
    }
}

