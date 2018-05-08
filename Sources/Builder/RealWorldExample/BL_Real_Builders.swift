//
//  BL_Real_Builders.swift
//  Patterns.RefactoringGuru
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol QueryBuilder {
    
    associatedtype Model: DomainModel
    
    typealias Predicate = OperationType<Model>.FilterClosure
    
    @discardableResult
    func limit(_ limit: Int) -> RealmQueryBuilder<Model>
    
    @discardableResult
    func filter(_ predicate: @escaping Predicate) -> RealmQueryBuilder<Model>
    
    var query: Query<Model> { get }
}


class RealmQueryBuilder<Model: DomainModel>: QueryBuilder {
    
    private var operations = [QueryOperation<Model>]()
    
    @discardableResult
    func limit(_ limit: Int) -> RealmQueryBuilder<Model> {
        let operation = QueryOperation<Model>(type: .limit(limit))
        operations.append(operation)
        return self
    }
    
    typealias Predicate = OperationType<Model>.FilterClosure
    
    @discardableResult
    func filter(_ predicate: @escaping Predicate) -> RealmQueryBuilder<Model> {
        let operation = QueryOperation<Model>(type: .filter(predicate))
        operations.append(operation)
        return self
    }
    
    var query: Query<Model> {
        return Query(operations: operations)
    }
}
