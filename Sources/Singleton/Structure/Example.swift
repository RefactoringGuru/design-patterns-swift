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

class SingletonStructuralExample: XCTestCase {

    /// EN: The client code.
    ///
    /// RU: Клиентский код.

    func testSingletonStructure() {

        let instance1 = Singleton.shared
        let instance2 = Singleton.shared

        print(instance1.someBusinessLogic())
        print(instance2.someBusinessLogic())

        /// EN: Both variables contain the same object. Otherwise, the assert would fail.
        ///
        /// RU: Обе переменные содержат один и тот же объект, иначе бы эта проверка не прошла.
        XCTAssert(instance1 === instance2)
    }
}

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

extension Singleton: NSCopying {

    /// EN: Singletons should not be cloneable.
    ///
    /// RU: Одиночки не должны быть клонируемыми.

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
