import XCTest

/// EN: Bridge Design Pattern
///
/// Intent: Decouple an abstraction from its implementation so that the two can
/// vary independently.
///
///               A
///            /     \                        A         N
///          Aa      Ab        ===>        /     \     / \
///         / \     /  \                 Aa(N) Ab(N)  1   2
///       Aa1 Aa2  Ab1 Ab2
///
/// RU: Паттерн Мост
///
/// Назначение: Разделяет абстракцию и реализацию, что позволяет изменять их
/// независимо друг от друга.
///
///               A
///            /     \                        A         N
///          Aa      Ab        ===>        /     \     / \
///         / \     /  \                 Aa(N) Ab(N)  1   2
///       Aa1 Aa2  Ab1 Ab2
///


/// EN: The Abstraction defines the interface for the "control" part of the two
/// class hierarchies. It maintains a reference to an object of the
/// Implementation hierarchy and delegates all of the real work to this object.
///
/// RU: Абстракция устанавливает интерфейс для «управляющей» части двух иерархий
/// классов. Она содержит ссылку на объект из иерархии Реализации и делегирует
/// ему всю настоящую работу.
class Abstraction {
    fileprivate var implementation: Implementation

    init(_ implementation: Implementation) {
        self.implementation = implementation
    }

    func operation() -> String {
        let operation = implementation.operationImplementation()
        return "Abstraction: Base operation with:\n" + operation
    }
}

/// EN: You can extend the Abstraction without changing the Implementation
/// classes.
///
/// RU: Можно расширить Абстракцию без изменения классов Реализации.
class ExtendedAbstraction: Abstraction {
    override func operation() -> String {
        let operation = implementation.operationImplementation()
        return "ExtendedAbstraction: Extended operation with:\n" + operation
    }
}

/// EN: The Implementation defines the interface for all implementation classes.
/// It doesn't have to match the Abstraction's interface. In fact, the two
/// interfaces can be entirely different. Typically the Implementation interface
/// provides only primitive operations, while the Abstraction defines higher-
/// level operations based on those primitives.
///
/// RU: Реализация устанавливает интерфейс для всех классов реализации. Он не
/// должен соответствовать интерфейсу Абстракции. На практике оба интерфейса
/// могут быть совершенно разными. Как правило, интерфейс Реализации
/// предоставляет только примитивные операции,  в то время как Абстракция
/// определяет операции более высокого уровня, основанные на этих примитивах.
protocol Implementation {
    func operationImplementation() -> String
}

/// EN: Each Concrete Implementation corresponds to a specific platform and
/// implements the Implementation interface using that platform's API.
///
/// RU: Каждая Конкретная Реализация соответствует определённой платформе  и
/// реализует интерфейс Реализации с использованием API этой платформы.
class ConcreteImplementationA: Implementation {
    func operationImplementation() -> String {
        return "ConcreteImplementationA: Here's the result on the platform A.\n"
    }
}

class ConcreteImplementationB: Implementation {
    func operationImplementation() -> String {
        return "ConcreteImplementationB: Here's the result on the platform B\n"
    }
}

/// EN: Except for the initialization phase, where an Abstraction object gets
/// linked with a specific Implementation object, the client code should only
/// depend on the Abstraction class. This way the client code can support any
/// abstraction-implementation combination.
///
/// RU: За исключением этапа инициализации, когда объект Абстракции связывается с
/// определённым объектом Реализации, клиентский код должен зависеть  только от
/// класса Абстракции. Таким образом, клиентский код может поддерживать  любую
/// комбинацию абстракции и реализации.
class Client {
    // ...
    static func someClientCode(abstraction: Abstraction) {
        print(abstraction.operation())
    }
    // ...
}

/// EN: Let's see how it all works.
///
/// RU: Давайте посмотрим как всё это будет работать.
class BridgeConceptualExample: XCTestCase {
    func testBridgeStructure() {
        // EN: The client code should be able to work with any pre-configured
        // abstraction-implementation combination.
        //
        // RU: Клиентский код должен работать с любой предварительно сконфигурированной
        // комбинацией абстракции и реализации.
        let implementation = ConcreteImplementationA()
        Client.someClientCode(abstraction: Abstraction(implementation))

        let concreteImplementation = ConcreteImplementationB()
        Client.someClientCode(abstraction: ExtendedAbstraction(concreteImplementation))
    }
}