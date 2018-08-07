//
//  TemplateMethodStructure.swift
//  TemplateMethodStructure
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// EN: Factory Method Design Pattern
///
/// Intent: Define an interface for creating an object, but let subclasses decide
/// which class to instantiate. Factory Method lets a class defer instantiation
/// to subclasses.
///
/// RU: Паттерн Фабричный Метод
///
/// Назначение: Определяет интерфейс для создания объекта, но позволяет
/// подклассам решать, какого класса создавать экземпляр. Фабричный Метод
/// позволяет классу делегировать создание экземпляра подклассам.

class TemplateMethodStructure: XCTestCase {
    
    func test() {
        
        /// EN: The client code works with an instance of a concrete creator, albeit
        /// through its base interface. As long as the client keeps working with the
        /// creator via the base interface, you can pass it any creator's subclass.
        ///
        /// RU: Клиентский код работает с экземпляром конкретного создателя, хотя и через
        /// его базовый интерфейс. Пока клиент продолжает работать с создателем через
        /// базовый интерфейс, вы можете передать ему любой подкласс создателя.
        
        /// EN: The Application picks a creator's type depending on the configuration
        /// or environment.
        ///
        /// RU: Приложение выбирает тип создателя в зависимости от конфигурации или среды.
        
        print("App: Launched with the ConcreteCreator1.\n")
        clientCode(creator: ConcreteCreator1())
        
        print("\n\nApp: Launched with the ConcreteCreator2.\n")
        clientCode(creator: ConcreteCreator2())
    }
    
    func clientCode(creator: Creator) {
        let result = creator.someOperation()
        print("Client: I'm not aware of the creator's class, but it still works.\n")
        print("Client: Result -> \(result)")
    }
}

/// EN: The Creator protocol declares the factory method that is supposed to return
/// an object of a Product class. The Creator's subclasses usually provide the
/// implementation of this method.
///
/// RU: Класс Создатель объявляет фабричный метод, который должен возвращать
/// объект класса Продукт. Подклассы Создателя обычно предоставляют реализацию
/// этого метода.

protocol Creator {
    
    /// EN: Note that the Creator may also provide some default implementation of
    /// the factory method.
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
    /// RU: Также заметьте, что, несмотря на название,  основная обязанность
    /// Создателя не заключается в создании продуктов.  Обычно он содержит
    /// некоторую базовую бизнес-логику, которая основана  на объектах Продуктов,
    /// возвращаемых фабричным методом.  Подклассы могут косвенно изменять эту
    /// бизнес-логику, переопределяя фабричный метод и возвращая из него другой
    /// тип продукта.
    
    func someOperation() -> String
}

extension Creator {
    
    func someOperation() -> String {
        /// Call the factory method to create a Product object.
        let product = factoryMethod()
        /// Now, use the product.
        let text = "Creator: The same creator's code has just worked with "
        return text + product.operation()
    }
}

/// EN: Concrete Creators override the factory method in order to change the
/// resulting product's type.
///
/// RU: Конкретные Создатели переопределяют фабричный метод для того, чтобы
/// изменить тип результирующего продукта.

class ConcreteCreator1: Creator {
    
    /// EN: Note that the signature of the method still uses the abstract product
    /// type, even though the concrete product is actually returned from the
    /// method. This way the Creator can stay independent of concrete product
    /// classes.
    ///
    /// RU: Обратите внимание, что сигнатура метода по-прежнему использует тип
    /// абстрактного продукта, хотя  фактически из метода возвращается конкретный
    /// продукт. Таким образом, Создатель может оставаться независимым от
    /// конкретных классов продуктов.
    
    func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    
    func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}

/// EN: The Product interface declares the operations that all concrete products
/// must implement.
///
/// RU: Интерфейс Продукта объявляет операции, которые должны выполнять все
/// конкретные продукты.

protocol Product {
    
    func operation() -> String
}

/// EN: Concrete Products provide various implementations of the Product interface.
///
/// RU: Конкретные Продукты предоставляют различные реализации интерфейса Продукта.

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
