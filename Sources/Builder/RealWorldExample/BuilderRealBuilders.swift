//
//  BuilderRealBuilders.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

class BaseQueryBuilder<Model: DomainModel> {

    typealias Predicate = (Model) -> (Bool)

    func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        return self
    }

    func filter(_ predicate: @escaping Predicate) -> BaseQueryBuilder<Model> {
        return self
    }

    func fetch() -> [Model] {
        preconditionFailure("Should be overridden in subclasses.")
    }
}

class RealmQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {

    enum Query {
        case filter(Predicate)
        case limit(Int)
        /// ...
    }

    fileprivate var operations = [Query]()

    @discardableResult
    override func limit(_ limit: Int) -> RealmQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }

    @discardableResult
    override func filter(_ predicate: @escaping Predicate) -> RealmQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }

    override func fetch() -> [Model] {
        print("RealmQueryBuilder: Initializing CoreDataProvider with \(operations.count) operations:")
        return RealmProvider().fetch(operations)
    }
}

class CoreDataQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {

    enum Query {
        case filter(Predicate)
        case limit(Int)
        case includesPropertyValues(Bool)
        /// ...
    }

    fileprivate var operations = [Query]()

    override func limit(_ limit: Int) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }

    override func filter(_ predicate: @escaping Predicate) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }

    func includesPropertyValues(_ toggle: Bool) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.includesPropertyValues(toggle))
        return self
    }

    override func fetch() -> [Model] {
        print("CoreDataQueryBuilder: Initializing CoreDataProvider with \(operations.count) operations.")
        return CoreDataProvider().fetch(operations)
    }
}
