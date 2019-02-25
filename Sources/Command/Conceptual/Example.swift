/// EN: Command Design Pattern
///
/// Intent: Encapsulate a request as an object, thereby letting you parameterize
/// clients with different requests (e.g. queue or log requests) and support
/// undoable operations.
///
/// RU: Паттерн Команда
///
/// Назначение: Инкапсулирует запрос как объект, позволяя тем
/// самым параметризовать клиентов с различными запросами (например, запросами
/// очереди или логирования) и поддерживать отмену операций.

import XCTest

/// EN: The Command interface declares a method for executing a command.
///
/// RU: Интерфейс Команды объявляет метод для выполнения команд.
protocol Command {

    func execute()
}

/// EN: Some commands can implement simple operations on their own.
///
/// RU: Некоторые команды способны выполнять простые операции самостоятельно.
class SimpleCommand: Command {

    private var payload: String

    init(_ payload: String) {
        self.payload = payload
    }

    func execute() {
        print("SimpleCommand: See, I can do simple things like printing (" + payload + ")")
    }
}

/// EN: However, some commands can delegate more complex operations to other
/// objects, called "receivers."
///
/// RU: Но есть и команды, которые делегируют более сложные операции другим
/// объектам, называемым «получателями».
class ComplexCommand: Command {

    private var receiver: Receiver

    /// EN: Context data, required for launching the receiver's methods.
    ///
    /// RU: Данные о контексте, необходимые для запуска методов получателя.
    private var a: String
    private var b: String

    /// EN: Complex commands can accept one or several receiver objects along
    /// with any context data via the constructor.
    ///
    /// RU: Сложные команды могут принимать один или несколько
    /// объектов-получателей вместе с любыми данными о контексте через конструктор.
    init(_ receiver: Receiver, _ a: String, _ b: String) {
        self.receiver = receiver
        self.a = a
        self.b = b
    }

    /// EN: Commands can delegate to any methods of a receiver.
    ///
    /// RU: Команды могут делегировать выполнение любым методам получателя.
    func execute() {
        print("ComplexCommand: Complex stuff should be done by a receiver object.\n")
        receiver.doSomething(a)
        receiver.doSomethingElse(b)
    }
}

/// EN: The Receiver classes contain some important business logic. They know how
/// to perform all kinds of operations, associated with carrying out a request.
/// In fact, any class may serve as a Receiver.
///
/// RU: Классы Получателей содержат некую важную бизнес-логику. Они умеют
/// выполнять все виды операций, связанных с выполнением запроса. Фактически,
/// любой класс может выступать Получателем.
class Receiver {

    func doSomething(_ a: String) {
        print("Receiver: Working on (" + a + ")\n")
    }

    func doSomethingElse(_ b: String) {
        print("Receiver: Also working on (" + b + ")\n")
    }
}

/// EN: The Invoker is associated with one or several commands. It sends a
/// request to the command.
///
/// RU: Отпрвитель связан с одной или несколькими командами. Он отправляет запрос
/// команде.
class Invoker {

    private var onStart: Command?

    private var onFinish: Command?

    /// EN: Initialize commands.
    ///
    /// RU: Инициализация команд.
    func setOnStart(_ command: Command) {
        onStart = command
    }

    func setOnFinish(_ command: Command) {
        onFinish = command
    }

    /// EN: The Invoker does not depend on concrete command or receiver classes.
    /// The Invoker passes a request to a receiver indirectly, by executing a command.
    ///
    /// RU: Отправитель не зависит от классов конкретных команд и получателей.
    /// Отправитель передаёт запрос получателю косвенно, выполняя команду.
    func doSomethingImportant() {

        print("Invoker: Does anybody want something done before I begin?")

        onStart?.execute()

        print("Invoker: ...doing something really important...")
        print("Invoker: Does anybody want something done after I finish?")

        onFinish?.execute()
    }
}

class CommandStructureExample: XCTestCase {
    func test() {
        /// EN: The client code can parameterize an invoker with any commands.
        ///
        /// RU: Клиентский код может параметризовать отправителя любыми командами.

        let invoker = Invoker()
        invoker.setOnStart(SimpleCommand("Say Hi!"))

        let receiver = Receiver()
        invoker.setOnFinish(ComplexCommand(receiver, "Send email", "Save report"))
        invoker.doSomethingImportant()
    }
}


