//
//  Operations.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 7/21/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

class DelayedOperation: Operation {

    private var delay: TimeInterval

    init(_ delay: TimeInterval = 0) {
        self.delay = delay
    }

    override var isExecuting : Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    private var _executing : Bool = false

    override var isFinished : Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    private var _finished : Bool = false

    override func start() {

        guard delay > 0 else {
            _start()
            return
        }

        let deadline = DispatchTime.now() + delay
        DispatchQueue(label: "").asyncAfter(deadline: deadline) {
            self._start()
        }
    }

    private func _start() {

        guard !self.isCancelled else {
            print("\(self): operation is canceled")
            self.isFinished = true
            return
        }

        self.isExecuting = true
        self.main()
        self.isExecuting = false
        self.isFinished = true
    }
}

class WindowOperation: DelayedOperation {

    override func main() {
        print("\(self): Windows are closed via HomeKit.")
    }

    override var description: String { return "WindowOperation" }
}

class DoorOperation: DelayedOperation {

    override func main() {
        print("\(self): Doors are closed via HomeKit.")
    }

    override var description: String { return "DoorOperation" }
}

class TaxiOperation: DelayedOperation {

    override func main() {
        print("\(self): Taxi is ordered via Uber")
    }

    override var description: String { return "TaxiOperation" }
}
