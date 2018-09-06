//
//  SingletonStructuralExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 4/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// EN: Singleton Design Pattern
///
/// Intent: Ensure that a class has a single instance, and provide a global point
/// of access to it.
///
/// RU: Паттерн Одиночка
///
/// Назначение: Гарантирует существование единственного экземпляра класса и
/// предоставляет глобальную точку доступа к нему.


/// EN: The Singleton class defines the `shared` field that lets clients
/// access the unique singleton instance.
///
/// RU: Класс Одиночка предоставляет поле `shared`, которое позволяет
/// клиентам получать доступ к уникальному экземпляру одиночки.
class Singleton {
    /// EN: The static field that controls the access to the singleton instance.
    ///
    /// This implementation let you extend the Singleton class while keeping
    /// just one instance of each subclass around.
    ///
    /// RU: Статическое поле, управляющие доступом к экземпляру одиночки.
    ///
    /// Эта реализация позволяет вам расширять класс Одиночки,
    /// сохраняя повсюду только один экземпляр каждого подкласса.
    static var shared: Singleton = {
        let instance = Singleton()
        // EN: ...
        // configure the instance
        // ...
        //
        // RU: ...
        // настройка объекта
        // ...
        return instance
    }()

    /// EN: The Singleton's initializer should always be private to prevent
    /// direct construction calls with the `new` operator.
    ///
    /// RU: Инициализатор Одиночки всегда должен быть скрытым, чтобы предотвратить
    /// прямое создание объекта через инициализатор.
    private init() {}

    /// EN: Finally, any singleton should define some business logic, which can
    /// be executed on its instance.
    ///
    /// RU: Наконец, любой одиночка должен содержать некоторую бизнес-логику,
    /// которая может быть выполнена на его экземпляре.
    func someBusinessLogic() -> String {
        // ...
        return "Result of the 'someBusinessLogic' call"
    }
}

/// EN: Singletons should not be cloneable.
///
/// RU: Одиночки не должны быть клонируемыми.
extension Singleton: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

/// EN: The client code.
///
/// RU: Клиентский код.
class Client {
    // ...
    static func someClientCode() {
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared

        if (instance1 === instance2) {
            print("Singleton works, both variables contain the same instance.");
        } else {
            print("Singleton failed, variables contain different instances.");
        }
    }
    // ...
}

/// EN: Let's see how it all works.
///
/// RU: Давайте посмотрим как всё это будет работать.
class SingletonStructuralExample: XCTestCase {
    func testSingletonStructure() {
        Client.someClientCode();
    }
}
