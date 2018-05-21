//
//  BL_Real_Query.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol OperationType {
    
    associatedtype Model: DomainModel
    
    typealias FilterClosure = (Model) -> (Bool)
}

enum RealmOperationType<Model: DomainModel>: OperationType {
        
    case filter(FilterClosure)
    case limit(Int)
    /// Other Realm operations
}

enum CoreDataOperationType<Model: DomainModel>: OperationType {
    
    case filter(FilterClosure)
    case limit(Int)
    case includesPropertyValues(Bool)
    /// Other CoreData operations
}

class Query<Operation: OperationType> {
    
    private(set) var operations: [Operation]
    
    init(operations: [Operation]) {
        self.operations = operations
    }
}
