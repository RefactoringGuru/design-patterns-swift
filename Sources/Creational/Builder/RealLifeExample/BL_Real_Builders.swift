//
//  BL_Real_Builders.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

class BaseQueryBuilder<Operation: OperationType> {
    
    typealias Predicate = Operation.FilterClosure
    
    fileprivate var operations = [Operation]()
    
    func limit(_ limit: Int) -> BaseQueryBuilder<Operation> {
        /// This is a base implementation. Should be overridden in subclasses
        return self
    }
    
    func filter(_ predicate: @escaping Predicate) -> BaseQueryBuilder<Operation> {
        /// This is a base implementation. Should be overridden in subclasses
        return self
    }
    
    var query: Query<Operation> {
        return Query(operations: operations)
    }
}

class RealmQueryBuilder<Model: DomainModel>: BaseQueryBuilder<RealmOperationType<Model>> {
    
    @discardableResult
    override func limit(_ limit: Int) -> RealmQueryBuilder<Model> {
        /// Operation of the Realm type will be added
        let operation = RealmOperationType<Model>.limit(limit)
        operations.append(operation)
        return self
    }
    
    @discardableResult
    override func filter(_ predicate: @escaping Predicate) -> RealmQueryBuilder<Model> {
        /// Operation of the Realm type will be added
        let operation = RealmOperationType<Model>.filter(predicate)
        operations.append(operation)
        return self
    }
}

class CoreDataQueryBuilder<Model: DomainModel>: BaseQueryBuilder<CoreDataOperationType<Model>> {
    
    override func limit(_ limit: Int) -> CoreDataQueryBuilder<Model> {
        /// Operation of the CoreData type will be added
        let operation = CoreDataOperationType<Model>.limit(limit)
        operations.append(operation)
        return self
    }
    
    override func filter(_ predicate: @escaping Predicate) -> CoreDataQueryBuilder<Model> {
        /// Operation of the CoreData type will be added
        let filter = CoreDataOperationType<Model>.filter(predicate)
        operations.append(filter)
        return self
    }
}
