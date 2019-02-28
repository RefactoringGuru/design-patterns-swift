/// EN: Adapter Design Pattern
///
/// Intent: Provides a unified interface that allows objects with incompatible
/// interfaces to collaborate.
///
/// RU: Паттерн Адаптер
///
/// Назначение: Позволяет объектам с несовместимыми интерфейсами работать
/// вместе.

import XCTest

/// EN: The Target defines the domain-specific interface used by the client
/// code.
///
/// RU: Целевой класс объявляет интерфейс, с которым может работать клиентский
/// код.
class Target {

    func request() -> String {
        return "Target: The default target's behavior."
    }
}

/// EN: The Adaptee contains some useful behavior, but its interface is
/// incompatible with the existing client code. The Adaptee needs some
/// adaptation before the client code can use it.
///
/// RU: Адаптируемый класс содержит некоторое полезное поведение, но его
/// интерфейс несовместим с существующим клиентским кодом. Адаптируемый класс
/// нуждается в некоторой доработке, прежде чем клиентский код сможет его
/// использовать.
class Adaptee {

    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
    }
}

/// EN: The Adapter makes the Adaptee's interface compatible with the Target's
/// interface.
///
/// RU: Адаптер делает интерфейс Адаптируемого класса совместимым с целевым
/// интерфейсом.
class Adapter: Target {

    private var adaptee: Adaptee

    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }

    override func request() -> String {
        return "Adapter: (TRANSLATED) " + adaptee.specificRequest().reversed()
    }
}

/// EN: The client code supports all classes that follow the Target interface.
///
/// RU: Клиентский код поддерживает все классы, использующие целевой интерфейс.
class Client {
    // ...
    static func someClientCode(target: Target) {
        print(target.request())
    }
    // ...
}

/// EN: Let's see how it all works together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class AdapterConceptualExample: XCTestCase {

    func testAdapterStructure() {
        print("Client: I can work just fine with the Target objects:")
        Client.someClientCode(target: Target())

        let adaptee = Adaptee()
        print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
        print("Adaptee: " + adaptee.specificRequest())

        print("Client: But I can work with it via the Adapter:")
        Client.someClientCode(target: Adapter(adaptee))
    }
}
