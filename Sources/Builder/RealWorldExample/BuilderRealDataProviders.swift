//
//  BuilderRealDataProviders.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

/// Data Providers contain a logic how to fetch models.
/// Builders accumulate operations and then update providers to fetch the data.

class RealmProvider {
    
    func fetch<Model: DomainModel>(_ operations: [RealmOperationType<Model>]) -> [Model] {
        
        print("Retrieving data from Realm")
        
        for item in operations {
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
    
    func fetch<Model: DomainModel>(_ operations: [CoreDataOperationType<Model>]) -> [Model] {
        
        /// Create a NSFetchRequest
        
        print("Retrieving data from CoreData")
        
        for item in operations {
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
