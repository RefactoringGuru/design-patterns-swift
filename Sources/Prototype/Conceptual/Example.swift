/// EN: Prototype Design Pattern
///
/// Intent: Produce new objects by copying existing ones without compromising
/// their internal structure.
///
/// RU: Паттерн Прототип
///
/// Назначение: Создаёт новые объекты, копируя существующие без нарушения их
/// внутренней структуры.

import XCTest

/// EN: Swift has built-in cloning support. To add cloning support to your
/// class, you need to implement the NSCopying protocol in that class
/// and provide the implementation for the `copy` method.
///
/// RU: Swift имеет встроенную поддержку клонирования. Чтобы сделать класс
/// клонируемым, вам нужно реализовать в нём протокол NSCopying, а именно
/// метод `copy`.
class BaseClass: NSCopying, Equatable {

    private var intValue = 1
    private var stringValue = "Value"

    required init(intValue: Int = 1, stringValue: String = "Value") {

        self.intValue = intValue
        self.stringValue = stringValue
    }

    /// MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let prototype = type(of: self).init()
        prototype.intValue = intValue
        prototype.stringValue = stringValue
        print("Values defined in BaseClass have been cloned!")
        return prototype
    }

    /// MARK: - Equatable
    static func == (lhs: BaseClass, rhs: BaseClass) -> Bool {
        return lhs.intValue == rhs.intValue && lhs.stringValue == rhs.stringValue
    }
}

/// EN: Subclasses can override the base `copy` method to copy their own data
/// into the resulting object. But you should always call the base method first.
///
/// RU: Подклассы могет переопределять базовый метод `copy`, чтобы дополнительно
/// скопировать данные собственного класса. Но в этом случае всегда сперва
/// вызывайте родительскую реализацию метод копирования.
class SubClass: BaseClass {

    private var boolValue = true

    func copy() -> Any {
        return copy(with: nil)
    }

    override func copy(with zone: NSZone?) -> Any {
        guard let prototype = super.copy(with: zone) as? SubClass else {
            return SubClass() // oops
        }
        prototype.boolValue = boolValue
        print("Values defined in SubClass have been cloned!")
        return prototype
    }
}

/// EN: The client code.
///
/// RU: Клиентский код.
class Client {
    // ...
    static func someClientCode() {
        let original = SubClass(intValue: 2, stringValue: "Value2")

        guard let copy = original.copy() as? SubClass else {
            XCTAssert(false)
            return
        }

        /// EN: See implementation of `Equatable` protocol for more details.
        ///
        /// RU: См. реализацию протокола `Equatable`.
        XCTAssert(copy == original)

        print("The original object is equal to the copied object!")
    }
    // ...
}

/// EN: Let's see how it all works together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class PrototypeConceptualExample: XCTestCase {

    func testPrototype_NSCopying() {
        Client.someClientCode();
    }
}
