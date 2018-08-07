//
//  StateStructure.swift
//  StateStructure
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// EN: State Design Pattern
///
/// Intent: Allow an object to alter its behavior when its internal state
/// changes. The object will appear to change its class.
///
/// RU: Паттерн Состояние
///
/// Назначение: Позволяет объекту менять поведение при изменении его внутреннего
/// состояния. Со стороны может казаться, что объект меняет свой класс.

class StateStructureExample: XCTestCase {
    
    func test() {
        let context = Context(ConcreteStateA())
        context.request1()
        context.request2()
    }
}

/// EN: The Context defines the interface of interest to clients. It also
/// maintains a reference to an instance of a State subclass, which represents
/// the current state of the Context.
///
/// RU: Контекст определяет интерфейс, представляющий интерес для клиентов. Он
/// также хранит ссылку на экземпляр подкласса Состояния, который отображает
/// текущее состояние Контекста.

class Context {
    
    private var state: State
    
    init(_ state: State) {
        self.state = state
        transitionTo(state: state)
    }
    
    func transitionTo(state: State) {
        /// EN: The Context allows changing the State object at runtime.
        ///
        /// RU: Контекст позволяет изменять объект Состояния во время выполнения.
        
        print("Context: Transition to " + String(describing: state))
        self.state = state
        self.state.update(context: self)
    }
    
    /// EN: The Context delegates part of its behavior to the current State object.
    ///
    /// RU: Контекст делегирует часть своего поведения текущему объекту Состояния.
    
    func request1() {
        state.handle1()
    }
    
    func request2() {
        state.handle2()
    }
}

/// EN: The base State class declares methods that all Concrete State should
/// implement and also provides a backreference to the Context object, associated
/// with the State. This backreference can be used by States to transition the
/// Context to another State.
///
/// RU: Базовый класс Состояния объявляет методы, которые должны реализовать все
/// Конкретные Состояния, а также предоставляет обратную ссылку на объект
/// Контекст, связанный с Состоянием. Эта обратная ссылка может использоваться
/// Состояниями для передачи Контекста другому Состоянию.

protocol State: class {
    
    func update(context: Context)
    
    func handle1()
    func handle2()
}

class BaseState: State {
    
    private(set) weak var context: Context?
    
    func update(context: Context) {
        self.context = context
    }
    
    func handle1() {}
    func handle2() {}
}

/// EN: Concrete States implement various behaviors, associated with a state of the Context.
///
/// RU: Конкретные Состояния реализуют различные модели поведения, связанные с
/// состоянием Контекста.

class ConcreteStateA: BaseState {
    
    override func handle1() {
        print("ConcreteStateA handles request1.")
        print("ConcreteStateA wants to change the state of the context.\n")
        context?.transitionTo(state: ConcreteStateB())
    }
    
    override func handle2() {
        print("ConcreteStateA handles request2.\n")
    }
}

class ConcreteStateB: BaseState {
    
    override func handle1() {
        print("ConcreteStateB handles request1.\n")
    }
    
    override func handle2() {
        print("ConcreteStateB handles request2.")
        print("ConcreteStateB wants to change the state of the context.\n")
        context?.transitionTo(state: ConcreteStateA())
    }
}
