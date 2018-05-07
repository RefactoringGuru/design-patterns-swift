//
//  BL_Real_Query.swift
//  PatternsForRefactoringGuru
//
//  Created by Maxim Eremenko on 5/7/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

enum OperationType<Model: DomainModel> {
    
    typealias FilterClosure = (Model) -> (Bool)
    
    case filter(FilterClosure)
    case limit(Int)
}

struct QueryOperation<Model: DomainModel> {
    
    let type: OperationType<Model>
    
    init(type: OperationType<Model>) {
        self.type = type
    }
}

class Query<Model: DomainModel> {
    
    private(set) var operations: [QueryOperation<Model>]
    
    init(operations: [QueryOperation<Model>]) {
        self.operations = operations
    }
}
