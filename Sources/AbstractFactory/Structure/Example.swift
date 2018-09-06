//
//  AbstractFactoryStructuralExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/4/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// EN: Abstract Factory Design Pattern
///
/// Intent: Provide an interface for creating families of related or dependent
/// objects without specifying their concrete classes.
///
/// RU: Паттерн Абстрактная Фабрика
///
/// Назначение: Предоставляет интерфейс для создания семейств связанных или
/// зависимых объектов без привязки к их конкретным классам.


/// EN: The Abstract Factory protocol declares a set of methods that return
/// different abstract products. These products are called a family and are
/// related by a high-level theme or concept. Products of one family are usually
/// able to collaborate among themselves. A family of products may have several
/// variations, but the products of one variation are incompatible with products
/// of another.
///
/// RU: Протокол Абстрактной Фабрики объявляет набор методов, которые возвращают
/// различные абстрактные продукты.  Эти продукты называются семейством и связаны
/// темой или концепцией высокого уровня. Продукты одного семейства обычно могут
/// взаимодействовать между собой. Семейство продуктов может иметь несколько
/// вариаций,  но продукты одной вариации несовместимы с продуктами другой.
protocol AbstractFactory {
    func createProductA() -> AbstractProductA
    func createProductB() -> AbstractProductB
}

/// EN: Concrete Factories produce a family of products that belong to a single
/// variation. The factory guarantees that resulting products are compatible.
/// Note that signatures of the Concrete Factory's methods return an abstract
/// product, while inside the method a concrete product is instantiated.
///
/// RU: Конкретная Фабрика производит семейство продуктов одной вариации. Фабрика
/// гарантирует совместимость полученных продуктов.  Обратите внимание, что
/// сигнатуры методов Конкретной Фабрики возвращают абстрактный продукт, в то
/// время как внутри метода создается экземпляр  конкретного продукта.
class ConcreteFactory1: AbstractFactory {
    func createProductA() -> AbstractProductA {
        return ConcreteProductA1()
    }

    func createProductB() -> AbstractProductB {
        return ConcreteProductB1()
    }
}

/// EN: Each Concrete Factory has a corresponding product variation.
///
/// RU: Каждая Конкретная Фабрика имеет соответствующую вариацию продукта.
class ConcreteFactory2: AbstractFactory {
    func createProductA() -> AbstractProductA {
        return ConcreteProductA2()
    }

    func createProductB() -> AbstractProductB {
        return ConcreteProductB2()
    }
}

/// EN: Each distinct product of a product family should have a base proocol.
/// All variations of the product must implement this proocol.
///
/// RU: Каждый отдельный продукт семейства продуктов должен иметь базовый
/// протокол. Все вариации продукта должны реализовывать этот протокол.
protocol AbstractProductA {
    func usefulFunctionA() -> String
}

/// EN: Concrete Products are created by corresponding Concrete Factories.
///
/// RU: Конкретные продукты создаются соответствующими Конкретными Фабриками.
class ConcreteProductA1: AbstractProductA {
    func usefulFunctionA() -> String {
        return "The result of the product A1."
    }
}

class ConcreteProductA2: AbstractProductA {
    func usefulFunctionA() -> String {
        return "The result of the product A2."
    }
}

/// EN: The base protocol of another product. All products can interact with
/// each other, but proper interaction is possible only between products of the
/// same concrete variation.
///
/// RU: Базовый протокол другого продукта. Все продукты могут взаимодействовать
/// друг с другом, но правильное взаимодействие возможно только между продуктами
/// одной и той же конкретной вариации.
protocol AbstractProductB {
    /// EN: Product B is able to do its own thing...
    ///
    /// RU: Продукт B способен работать самостоятельно...
    func usefulFunctionB() -> String

    /// EN: ...but it also can collaborate with the ProductA.
    ///
    /// The Abstract Factory makes sure that all products it creates are of
    /// the same variation and thus, compatible.
    ///
    /// RU: ...а также взаимодействовать с Продуктами Б той же вариации.
    ///
    /// Абстрактная Фабрика гарантирует, что все продукты, которые она
    /// создает, имеют одинаковую вариацию и, следовательно, совместимы.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String
}

/// EN: Concrete Products are created by corresponding Concrete Factories.
///
/// RU: Конкретные Продукты создаются соответствующими Конкретными Фабриками.
class ConcreteProductB1: AbstractProductB {
    func usefulFunctionB() -> String {
        return "The result of the product B1."
    }

    /// EN: This variant, Product B1, is only able to work correctly with the
    /// variant, Product A1. Nevertheless, it accepts any instance of
    /// AbstractProductA as an argument.
    ///
    /// RU: Продукт B1 может корректно работать только с Продуктом A1. Тем не
    /// менее, он принимает любой экземпляр Абстрактного Продукта А в качестве
    /// аргумента.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B1 collaborating with the (\(result))"
    }
}

class ConcreteProductB2: AbstractProductB {
    func usefulFunctionB() -> String {
        return "The result of the product B2."
    }

    /// EN: This variant, Product B2, is only able to work correctly with the
    /// variant, Product A2. Nevertheless, it accepts any instance of
    /// AbstractProductA as an argument.
    ///
    /// RU: Продукт B2 может корректно работать только с Продуктом A2. Тем не
    /// менее, он принимает любой экземпляр Абстрактного Продукта А в качестве
    /// аргумента.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B2 collaborating with the (\(result))"
    }
}

/// EN: The client code works with factories and products only through abstract
/// types: AbstractFactory and AbstractProduct. This lets you pass any factory or
/// product subclass to the client code without breaking it.
///
/// RU: Клиентский код работает с фабриками и продуктами только через абстрактные
/// типы: Абстрактная Фабрика и Абстрактный Продукт. Это позволяет передавать
/// любой подкласс фабрики или продукта клиентскому коду, не нарушая его.
class Client {
    // ...
    static func someClientCode(factory: AbstractFactory) {
        let productA = factory.createProductA()
        let productB = factory.createProductB()

        print(productB.usefulFunctionB())
        print(productB.anotherUsefulFunctionB(collaborator: productA))
    }
    // ...
}

/// EN: Let's see how it all works.
///
/// RU: Давайте посмотрим как всё это будет работать.
class AbstractFactoryStructuralExample: XCTestCase {
    func testAbstractFactoryStructure() {

        /// EN: The client code can work with any concrete factory class.
        ///
        /// RU: Клиентский код может работать с любым конкретным классом фабрики.

        print("Client: Testing client code with the first factory type:")
        Client.someClientCode(factory: ConcreteFactory1())

        print("Client: Testing the same client code with the second factory type:")
        Client.someClientCode(factory: ConcreteFactory2())
    }
}
