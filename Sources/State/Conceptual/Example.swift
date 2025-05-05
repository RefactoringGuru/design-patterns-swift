/// EN: State Design Pattern
///
/// Intent: Lets an object alter its behavior when its internal state changes.
/// It appears as if the object changed its class.
///
/// RU: Паттерн Состояние
///
/// Назначение: Позволяет объектам менять поведение в зависимости от своего
/// состояния. Извне создаётся впечатление, что изменился класс объекта.

import XCTest

/// EN: The Context defines the interface of interest to clients. It also
/// maintains a reference to an instance of a State subclass, which represents
/// the current state of the Context.
///
/// RU: Контекст определяет интерфейс, представляющий интерес для клиентов. Он
/// также хранит ссылку на экземпляр подкласса Состояния, который отображает
/// текущее состояние Контекста.
class Context {

    /// EN: A reference to the current state of the Context.
    ///
    /// RU: Ссылка на текущее состояние Контекста.
    private var state: State

    init(_ state: State) {
        self.state = state
        transitionTo(state: state)
    }

    /// EN: The Context allows changing the State object at runtime.
    ///
    /// RU: Контекст позволяет изменять объект Состояния во время выполнения.
    func transitionTo(state: State) {
        print("Context: Transition to " + String(describing: state))
        self.state = state
        self.state.update(context: self)
    }

    /// EN: The Context delegates part of its behavior to the current State
    /// object.
    ///
    /// RU: Контекст делегирует часть своего поведения текущему объекту
    /// Состояния.
    func request1() {
        state.handle1()
    }

    func request2() {
        state.handle2()
    }
}

/// EN: The base State class declares methods that all Concrete State should
/// implement and also provides a backreference to the Context object,
/// associated with the State. This backreference can be used by States to
/// transition the Context to another State.
///
/// RU: Базовый класс Состояния объявляет методы, которые должны реализовать все
/// Конкретные Состояния, а также предоставляет обратную ссылку на объект
/// Контекст, связанный с Состоянием. Эта обратная ссылка может использоваться
/// Состояниями для передачи Контекста другому Состоянию.
protocol State: AnyObject {

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

/// EN: Concrete States implement various behaviors, associated with a state of
/// the Context.
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

/// EN: Let's see how it all works together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class StateConceptual: XCTestCase {

    func test() {
        let context = Context(ConcreteStateA())
        context.request1()
        context.request2()
    }
}