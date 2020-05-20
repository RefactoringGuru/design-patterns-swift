/// EN: Factory Method Design Pattern
///
/// Intent: Provides an interface for creating objects in a superclass, but
/// allows subclasses to alter the type of objects that will be created.
///
/// RU: Паттерн Фабричный Метод
///
/// Назначение: Определяет общий интерфейс для создания объектов в суперклассе,
/// позволяя подклассам изменять тип создаваемых объектов.

import XCTest

/// EN: The Creator protocol declares the factory method that's supposed to
/// return a new object of a Product class. The Creator's subclasses usually
/// provide the implementation of this method.
///
/// RU: Класс Создатель объявляет фабричный метод, который должен возвращать
/// объект класса Продукт. Подклассы Создателя обычно предоставляют реализацию
/// этого метода.
protocol Creator {

    /// EN: Note that the Creator may also provide some default implementation
    /// of the factory method.
    ///
    /// RU: Обратите внимание, что Создатель может также обеспечить реализацию
    /// фабричного метода по умолчанию.
    func factoryMethod() -> Product

    /// EN: Also note that, despite its name, the Creator's primary
    /// responsibility is not creating products. Usually, it contains some core
    /// business logic that relies on Product objects, returned by the factory
    /// method. Subclasses can indirectly change that business logic by
    /// overriding the factory method and returning a different type of product
    /// from it.
    ///
    /// RU: Также заметьте, что, несмотря на название, основная обязанность
    /// Создателя не заключается в создании продуктов. Обычно он содержит
    /// некоторую базовую бизнес-логику, которая основана на объектах Продуктов,
    /// возвращаемых фабричным методом. Подклассы могут косвенно изменять эту
    /// бизнес-логику, переопределяя фабричный метод и возвращая из него другой
    /// тип продукта.
    func someOperation() -> String
}

/// EN: This extension implements the default behavior of the Creator. This
/// behavior can be overridden in subclasses.
///
/// RU: Это расширение реализует базовое поведение Создателя. Оно может быть
/// переопределено в подклассах.
extension Creator {

    func someOperation() -> String {
        // EN: Call the factory method to create a Product object.
        //
        // RU: Вызываем фабричный метод, чтобы получить объект-продукт.
        let product = factoryMethod()

        // EN: Now, use the product.
        //
        // RU: Далее, работаем с этим продуктом.
        return "Creator: The same creator's code has just worked with " + product.operation()
    }
}

/// EN: Concrete Creators override the factory method in order to change the
/// resulting product's type.
///
/// RU: Конкретные Создатели переопределяют фабричный метод для того, чтобы
/// изменить тип результирующего продукта.
class ConcreteCreator1: Creator {

    /// EN: Note that the signature of the method still uses the abstract
    /// product type, even though the concrete product is actually returned from
    /// the method. This way the Creator can stay independent of concrete
    /// product classes.
    ///
    /// RU: Обратите внимание, что сигнатура метода по-прежнему использует тип
    /// абстрактного продукта, хотя фактически из метода возвращается конкретный
    /// продукт. Таким образом, Создатель может оставаться независимым от
    /// конкретных классов продуктов.
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {

    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}

/// EN: The Product protocol declares the operations that all concrete products
/// must implement.
///
/// RU: Протокол Продукта объявляет операции, которые должны выполнять все
/// конкретные продукты.
protocol Product {

    func operation() -> String
}

/// EN: Concrete Products provide various implementations of the Product
/// protocol.
///
/// RU: Конкретные Продукты предоставляют различные реализации протокола
/// Продукта.
class ConcreteProduct1: Product {

    func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}

class ConcreteProduct2: Product {

    func operation() -> String {
        return "{Result of the ConcreteProduct2}"
    }
}


/// EN: The client code works with an instance of a concrete creator, albeit
/// through its base protocol. As long as the client keeps working with the
/// creator via the base protocol, you can pass it any creator's subclass.
///
/// RU: Клиентский код работает с экземпляром конкретного создателя, хотя и
/// через его базовый протокол. Пока клиент продолжает работать с создателем
/// через базовый протокол, вы можете передать ему любой подкласс создателя.
class Client {
    // ...
    static func someClientCode(creator: Creator) {
        print("Client: I'm not aware of the creator's class, but it still works.\n"
            + creator.someOperation())
    }
    // ...
}

/// EN: Let's see how it all works together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class FactoryMethodConceptual: XCTestCase {

    func testFactoryMethodConceptual() {

        /// EN: The Application picks a creator's type depending on the
        /// configuration or environment.
        ///
        /// RU: Приложение выбирает тип создателя в зависимости от конфигурации
        /// или среды.

        print("App: Launched with the ConcreteCreator1.")
        Client.someClientCode(creator: ConcreteCreator1())

        print("\nApp: Launched with the ConcreteCreator2.")
        Client.someClientCode(creator: ConcreteCreator2())
    }
}
