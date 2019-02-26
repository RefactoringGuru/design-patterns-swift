/// EN: Strategy Design Pattern
///
/// Intent: Define a family of algorithms, encapsulate each one, and make them
/// interchangeable. Strategy lets the algorithm vary independently from clients
/// that use it.
///
/// RU: Паттерн Стратегия
///
/// Назначение: Определяет семейство алгоритмов, инкапсулирует каждый из них и
/// делает взаимозаменяемыми. Стратегия позволяет изменять алгоритм независимо от
/// клиентов, которые его используют.

import XCTest

/// EN: The Context defines the interface of interest to clients.
///
/// RU: Контекст определяет интерфейс, представляющий интерес для клиентов.
class Context {

    /// EN: The Context maintains a reference to one of the Strategy objects. The
    /// Context does not know the concrete class of a strategy. It should work
    /// with all strategies via the Strategy interface.
    ///
    /// RU: Контекст хранит ссылку на один из объектов Стратегии. Контекст не
    /// знает конкретного класса стратегии. Он должен работать со всеми
    /// стратегиями через интерфейс Стратегии.
    private var strategy: Strategy

    /// EN: Usually, the Context accepts a strategy through the constructor, but
    /// also provides a setter to change it at runtime.
    ///
    /// RU: Обычно Контекст принимает стратегию через конструктор, а также
    /// предоставляет сеттер для её изменения во время выполнения.
    init(strategy: Strategy) {
        self.strategy = strategy
    }

    /// EN: Usually, the Context allows replacing a Strategy object at runtime.
    ///
    /// RU: Обычно Контекст позволяет заменить объект Стратегии во время
    /// выполнения.
    func update(strategy: Strategy) {
        self.strategy = strategy
    }

    /// EN: The Context delegates some work to the Strategy object instead of
    /// implementing multiple versions of the algorithm on its own.
    ///
    /// RU: Вместо того, чтобы самостоятельно реализовывать множественные версии
    /// алгоритма, Контекст делегирует некоторую работу объекту Стратегии.
    func doSomeBusinessLogic() {
        print("Context: Sorting data using the strategy (not sure how it'll do it)\n")

        let result = strategy.doAlgorithm(["a", "b", "c", "d", "e"])
        print(result.joined(separator: ","))
    }
}

/// EN: The Strategy interface declares operations common to all supported
/// versions of some algorithm.
///
/// The Context uses this interface to call the algorithm defined by Concrete
/// Strategies.
///
/// RU: Интерфейс Стратегии объявляет операции, общие для всех поддерживаемых
/// версий некоторого алгоритма.
///
/// Контекст использует этот интерфейс для вызова алгоритма, определённого
/// Конкретными Стратегиями.
protocol Strategy {

    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T]
}

/// EN: Concrete Strategies implement the algorithm while following the base
/// Strategy interface. The interface makes them interchangeable in the Context.
///
/// RU: Конкретные Стратегии реализуют алгоритм, следуя базовому интерфейсу
/// Стратегии. Этот интерфейс делает их взаимозаменяемыми в Контексте.
class ConcreteStrategyA: Strategy {

    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted()
    }
}

class ConcreteStrategyB: Strategy {

    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted(by: >)
    }
}

/// EN: Let's see how it all works together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class StrategyStructure: XCTestCase {

    func test() {

        /// EN: The client code picks a concrete strategy and passes it to the
        /// context. The client should be aware of the differences between
        /// strategies in order to make the right choice.
        ///
        /// RU: Клиентский код выбирает конкретную стратегию и передаёт её в
        /// контекст. Клиент должен знать о различиях между стратегиями, чтобы
        /// сделать правильный выбор.

        let context = Context(strategy: ConcreteStrategyA())
        print("Client: Strategy is set to normal sorting.\n")
        context.doSomeBusinessLogic()

        print("\nClient: Strategy is set to reverse sorting.\n")
        context.update(strategy: ConcreteStrategyB())
        context.doSomeBusinessLogic()
    }
}