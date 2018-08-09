//
//  CommandReal.swift
//  Example
//
//  Created by Maxim Eremenko on 7/11/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class CommandRealExample: XCTestCase {
    
    func test() {
        prepareTestEnvironment {
            
            let siri = SiriShortcuts.shared
            
            print("User: Hey Siri, I am leaving my home")
            siri.perform(.leaveHome)
            
            print("User: Hey Siri, I am leaving my work in 3 minutes")
            siri.perform(.leaveWork, delay: 3) /// for simplicity, we use seconds
            
            print("User: Hey Siri, I am still working")
            siri.cancel(.leaveWork)
        }
    }
}

extension CommandRealExample {
    
    struct ExecutionTime {
        static let max: TimeInterval = 5
        static let waiting: TimeInterval = 4
    }
    
    func prepareTestEnvironment(_ execution: () -> ()) {
        
        /// This method tells Xcode to wait for async operations.
        /// Otherwise the main test is done immediately.
        
        let expectation = self.expectation(description: "Expectation for async operations")
        
        let deadline = DispatchTime.now() + ExecutionTime.waiting
        DispatchQueue.main.asyncAfter(deadline: deadline) { expectation.fulfill() }
        
        execution()
        
        wait(for: [expectation], timeout: ExecutionTime.max)
    }
}

class SiriShortcuts {
    
    static let shared = SiriShortcuts()
    private lazy var queue = OperationQueue()
    
    private init() {}
    
    enum Action: String {
        case leaveHome
        case leaveWork
    }
    
    func perform(_ action: Action, delay: TimeInterval = 0) {
        print("Siri: performing \(action)-action\n")
        switch action {
        case .leaveHome:
            add(operation: WindowOperation(delay))
            add(operation: DoorOperation(delay))
        case .leaveWork:
            add(operation: TaxiOperation(delay))
        }
    }
    
    func cancel(_ action: Action) {
        print("Siri: canceling \(action)-action\n")
        switch action {
        case .leaveHome:
            cancelOperation(with: WindowOperation.self)
            cancelOperation(with: DoorOperation.self)
        case .leaveWork:
            cancelOperation(with: TaxiOperation.self)
        }
    }
    
    private func cancelOperation(with operationType: Operation.Type) {
        queue.operations.filter { operation in
            return type(of: operation) == operationType
        }.forEach({ $0.cancel() })
    }
    
    private func add(operation: Operation) {
        queue.addOperation(operation)
    }
}
