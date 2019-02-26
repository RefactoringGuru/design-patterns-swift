/// EN: Template Method Design Pattern
///
/// Intent: Define the skeleton of an algorithm, deferring implementation of some
/// steps to subclasses. Template Method lets subclasses redefine specific steps
/// of an algorithm without changing the algorithm's structure.
///
/// RU: Паттерн Шаблонный метод
///
/// Назначение: Определяет общую схему алгоритма, перекладывая реализацию
/// некоторых шагов  на подклассы. Шаблонный метод позволяет подклассам
/// переопределять отдельные шаги алгоритма без изменения структуры алгоритма.

import XCTest


/// EN: The Abstract Protocol and its extension defines a template method that
/// contains a skeleton of some algorithm, composed of calls to (usually)
/// abstract primitive operations.
///
/// Concrete subclasses should implement these operations, but leave the template
/// method itself intact.
///
/// RU: Абстрактный Протокол и его расширение определяет шаблонный метод,
/// содержащий скелет некоторого алгоритма, состоящего из вызовов (обычно)
/// абстрактных примитивных операций.
///
/// Конкретные подклассы должны реализовать эти операции, но оставить сам
/// шаблонный метод без изменений.
protocol AbstractProtocol {

    /// EN: The template method defines the skeleton of an algorithm.
    ///
    /// RU: Шаблонный метод определяет скелет алгоритма.
    func templateMethod()

    /// EN: These operations already have implementations.
    ///
    /// RU: Эти операции уже имеют реализации.
    func baseOperation1()

    func baseOperation2()

    func baseOperation3()

    /// EN: These operations have to be implemented in subclasses.
    ///
    /// RU: А эти операции должны быть реализованы в подклассах.
    func requiredOperations1()
    func requiredOperation2()

    /// EN: These are "hooks." Subclasses may override them, but it's not
    /// mandatory since the hooks already have default (but empty)
    /// implementation. Hooks provide additional extension points in some crucial
    /// places of the algorithm.
    ///
    /// RU: Это «хуки». Подклассы могут переопределять их, но это не обязательно,
    /// поскольку у хуков уже есть стандартная (но пустая) реализация. Хуки
    /// предоставляют дополнительные точки расширения в некоторых критических
    /// местах алгоритма.
    func hook1()
    func hook2()
}

extension AbstractProtocol {

    func templateMethod() {
        baseOperation1()
        requiredOperations1()
        baseOperation2()
        hook1()
        requiredOperation2()
        baseOperation3()
        hook2()
    }

    /// EN: These operations already have implementations.
    ///
    /// RU: Эти операции уже имеют реализации.
    func baseOperation1() {
        print("AbstractProtocol says: I am doing the bulk of the work\n")
    }

    func baseOperation2() {
        print("AbstractProtocol says: But I let subclasses override some operations\n")
    }

    func baseOperation3() {
        print("AbstractProtocol says: But I am doing the bulk of the work anyway\n")
    }

    func hook1() {}
    func hook2() {}
}

/// EN: Concrete classes have to implement all abstract operations of the base
/// class. They can also override some operations with a default implementation.
///
/// RU: Конкретные классы должны реализовать все абстрактные операции базового
/// класса. Они также могут переопределить некоторые операции с реализацией по
/// умолчанию.
class ConcreteClass1: AbstractProtocol {

    func requiredOperations1() {
        print("ConcreteClass1 says: Implemented Operation1\n")
    }

    func requiredOperation2() {
        print("ConcreteClass1 says: Implemented Operation2\n")
    }

    func hook2() {
        print("ConcreteClass1 says: Overridden Hook2\n")
    }
}

/// EN: Usually, concrete classes override only a fraction of base class'
/// operations.
///
/// RU: Обычно конкретные классы переопределяют только часть операций базового
/// класса.
class ConcreteClass2: AbstractProtocol {

    func requiredOperations1() {
        print("ConcreteClass2 says: Implemented Operation1\n")
    }

    func requiredOperation2() {
        print("ConcreteClass2 says: Implemented Operation2\n")
    }

    func hook1() {
        print("ConcreteClass2 says: Overridden Hook1\n")
    }
}

/// EN: The client code calls the template method to execute the algorithm.
/// Client code does not have to know the concrete class of an object it works
/// with, as long as it works with objects through the interface of their base
/// class.
///
/// RU: Клиентский код вызывает шаблонный метод для выполнения алгоритма.
/// Клиентский код не должен знать конкретный класс объекта, с которым работает,
/// при условии, что он работает с объектами через интерфейс их базового класса.
class Client {
    // ...
    static func clientCode(use object: AbstractProtocol) {
        // ...
        object.templateMethod()
        // ...
    }
    // ...
}


/// EN: Let's see how it all works together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class TemplateMethodStructureExample: XCTestCase {

    func test() {

        print("Same client code can work with different subclasses:\n")
        Client.clientCode(use: ConcreteClass1())

        print("\nSame client code can work with different subclasses:\n")
        Client.clientCode(use: ConcreteClass2())
    }
}
