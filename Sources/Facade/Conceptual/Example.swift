/// EN: Facade Design Pattern
///
/// Intent: Provide a unified interface to a number of classes/interfaces of a
/// complex subsystem. The Facade pattern defines a higher-level interface that
/// makes the subsystem easier to use.
///
/// RU: Паттерн Фасад
///
/// Назначение: Предоставляет единый интерфейс к ряду классов/интерфейсов сложной
/// подсистемы. Паттерн Фасад определяет интерфейс более высокого уровня, который
/// упрощает использование подсистемы.

import XCTest

/// EN: The Facade class provides a simple interface to the complex logic of one
/// or several subsystems. The Facade delegates the client requests to the
/// appropriate objects within the subsystem. The Facade is also responsible for
/// managing their lifecycle. All of this shields the client from the undesired
/// complexity of the subsystem.
///
/// RU: Класс Фасада предоставляет простой интерфейс для сложной логики одной или
/// нескольких подсистем. Фасад делегирует запросы клиентов соответствующим
/// объектам внутри подсистемы. Фасад также отвечает за управление их жизненным
/// циклом. Все это защищает клиента от нежелательной сложности подсистемы.
class Facade
{
    private var subsystem1: Subsystem1
    private var subsystem2: Subsystem2

    /// EN: Depending on your application's needs, you can provide the Facade
    /// with existing subsystem objects or force the Facade to create them on its
    /// own.
    ///
    /// RU: В зависимости от потребностей вашего приложения вы можете
    /// предоставить Фасаду существующие объекты подсистемы или заставить Фасад
    /// создать их самостоятельно.
    init(subsystem1: Subsystem1 = Subsystem1(),
         subsystem2: Subsystem2 = Subsystem2()) {
        self.subsystem1 = subsystem1
        self.subsystem2 = subsystem2
    }

    /// EN: The Facade's methods are convenient shortcuts to the sophisticated
    /// functionality of the subsystems. However, clients get only to a fraction
    /// of a subsystem's capabilities.
    ///
    /// RU: Методы Фасада удобны для быстрого доступа к сложной функциональности
    /// подсистем. Однако клиенты получают только часть возможностей подсистемы.
    func operation() -> String {

        var result = "Facade initializes subsystems:"
        result += " " + subsystem1.operation1()
        result += " " + subsystem2.operation1()
        result += "\n" + "Facade orders subsystems to perform the action:\n"
        result += " " + subsystem1.operationN()
        result += " " + subsystem2.operationZ()
        return result
    }
}

/// EN: The Subsystem can accept requests either from the facade or client
/// directly. In any case, to the Subsystem, the Facade is yet another client,
/// and it's not a part of the Subsystem.
///
/// RU: Подсистема может принимать запросы либо от фасада, либо от клиента
/// напрямую. В любом случае, для Подсистемы Фасад – это еще один клиент,  и он
/// не является частью Подсистемы.
class Subsystem1
{
    func operation1() -> String {
        return "Sybsystem1: Ready!\n"
    }

    // ...

    func operationN() -> String {
        return "Sybsystem1: Go!\n"
    }
}

/// EN: Some facades can work with multiple subsystems at the same time.
///
/// RU: Некоторые фасады могут работать с разными подсистемами одновременно.
class Subsystem2 {

    func operation1() -> String {
        return "Sybsystem2: Get ready!\n"
    }

    // ...

    func operationZ() -> String {
        return "Sybsystem2: Fire!\n"
    }
}

/// EN: The client code works with complex subsystems through a simple interface
/// provided by the Facade. When a facade manages the lifecycle of the subsystem,
/// the client might not even know about the existence of the subsystem. This
/// approach lets you keep the complexity under control.
///
/// RU: Клиентский код работает со сложными подсистемами через простой интерфейс,
/// предоставляемый Фасадом. Когда фасад управляет жизненным циклом подсистемы,
/// клиент может даже не знать о существовании подсистемы. Такой подход позволяет
/// держать сложность под контролем.
class Client {
    // ...
    static func clientCode(facade: Facade) {
        print(facade.operation())
    }
    // ...
}

/// EN: Let's see how it all works.
///
/// RU: Давайте посмотрим как всё это будет работать.
class FacadeConceptualExample: XCTestCase {

    func testFacadeStructure() {

        /// EN: The client code may have some of the subsystem's objects already created.
        /// In this case, it might be worthwhile to initialize the Facade with these
        /// objects instead of letting the Facade create new instances.
        ///
        /// RU: В клиентском коде могут быть уже созданы некоторые объекты подсистемы. В
        /// этом случае может оказаться целесообразным инициализировать Фасад с этими
        /// объектами вместо того, чтобы позволить Фасаду создавать новые экземпляры.

        let subsystem1 = Subsystem1()
        let subsystem2 = Subsystem2()
        let facade = Facade(subsystem1: subsystem1, subsystem2: subsystem2)
        Client.clientCode(facade: facade)
    }
}

