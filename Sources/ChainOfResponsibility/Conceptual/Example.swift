/// EN: Chain of Responsibility Design Pattern
///
/// Intent: Avoid coupling a sender of a request to its receiver by giving more
/// than one object a chance to handle the request. Chain the receiving objects
/// and then pass the request through the chain until some receiver handles it.
///
/// RU: Паттерн Цепочка обязанностей
///
/// Назначение: Позволяет избежать привязки отправителя запроса к его получателю,
/// предоставляя возможность обработать запрос нескольким объектам. Связывает в
/// цепочку объекты-получатели, а затем передаёт запрос по цепочке, пока некий
/// получатель не обработает его.

import XCTest

/// EN: The Handler interface declares a method for building the chain of
/// handlers. It also declares a method for executing a request.
///
/// RU: Интерфейс Обработчика объявляет метод построения цепочки обработчиков. Он
/// также объявляет метод для выполнения запроса.
protocol Handler: class {

    @discardableResult
    func setNext(handler: Handler) -> Handler

    func handle(request: String) -> String?

    var nextHandler: Handler? { get set }
}

extension Handler {

    func setNext(handler: Handler) -> Handler {
        self.nextHandler = handler

        /// EN: Returning a handler from here will let us link handlers in a
        /// convenient way like this:
        /// monkey.setNext(handler: squirrel).setNext(handler: dog)
        ///
        /// RU: Возврат обработчика отсюда позволит связать обработчики простым
        /// способом, вот так:
        /// monkey.setNext(handler: squirrel).setNext(handler: dog)
        return handler
    }

    func handle(request: String) -> String? {
        return nextHandler?.handle(request: request)
    }
}

/// EN: All Concrete Handlers either handle a request or pass it to the next
/// handler in the chain.
///
/// RU: Все Конкретные Обработчики либо обрабатывают запрос, либо передают его
/// следующему обработчику в цепочке.
class MonkeyHandler: Handler {

    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if (request == "Banana") {
            return "Monkey: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class SquirrelHandler: Handler {

    var nextHandler: Handler?

    func handle(request: String) -> String? {

        if (request == "Nut") {
            return "Squirrel: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class DogHandler: Handler {

    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if (request == "MeatBall") {
            return "Dog: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

/// EN: The client code is usually suited to work with a single handler.
/// In most cases, it is not even aware that the handler is part of a chain.
///
/// RU: Обычно клиентский код приспособлен для работы с единственным
/// обработчиком. В большинстве случаев клиенту даже неизвестно, что этот
/// обработчик является частью цепочки.
class Client {
    // ...
    static func someClientCode(handler: Handler) {

        let food = ["Nut", "Banana", "Cup of coffee"]

        for item in food {

            print("Client: Who wants a " + item + "?\n")

            guard let result = handler.handle(request: item) else {
                print("  " + item + " was left untouched.\n")
                return
            }

            print("  " + result)
        }
    }
    // ...
}

/// EN: Let's see how it all works.
///
/// RU: Давайте посмотрим как всё это будет работать.
class ChainOfResponsibilityStructureExample: XCTestCase {
    func test() {

        /// EN: The other part of the client code constructs the actual chain.
        ///
        /// RU: Другая часть клиентского кода создает саму цепочку.

        let monkey = MonkeyHandler()
        let squirrel = SquirrelHandler()
        let dog = DogHandler()
        monkey.setNext(handler: squirrel).setNext(handler: dog)

        /// EN: The client should be able to send a request to any handler,
        /// not just the first one in the chain.
        ///
        /// RU: Клиент должен иметь возможность отправлять запрос любому
        /// обработчику, а не только первому в цепочке.

        print("Chain: Monkey > Squirrel > Dog\n\n")
        Client.someClientCode(handler: monkey)
        print()
        print("Subchain: Squirrel > Dog\n\n")
        Client.someClientCode(handler: squirrel)
    }
}

