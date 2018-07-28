//
//  MementoStructure.swift
//  MementoStructure
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// EN: Memento Design Pattern
///
/// Intent: Capture and externalize an object's internal state so that the object
/// can be restored to this state later, without violating encapsulation.
///
/// RU: Паттерн Снимок
///
/// Назначение: Фиксирует и восстанавливает внутреннее состояние объекта таким
/// образом, чтобы  в дальнейшем объект можно было восстановить в этом состоянии
/// без нарушения инкапсуляции.

class MementoStructure: XCTestCase {
    
    /// EN: The Originator holds some important state that may change over time. It
    /// also defines a method for saving the state inside a memento and another
    /// method for restoring the state from it.
    ///
    /// RU: Создатель содержит некоторое важное состояние, которое может со временем
    /// меняться. Он также объявляет метод сохранения состояния внутри снимка и метод
    /// восстановления состояния из него.
    
    func test() {
        
        let originator = Originator(state: "Super-duper-super-puper-super.")
        let caretaker = Caretaker(originator: originator)
        
        caretaker.backup()
        originator.doSomething()
        
        caretaker.backup()
        originator.doSomething()
        
        caretaker.backup()
        originator.doSomething()
        
        print("\n")
        caretaker.showHistory()
        
        print("\nClient: Now, let's rollback!\n\n")
        caretaker.undo()
        
        print("\nClient: Once more!\n\n")
        caretaker.undo()
    }
}

class Originator {
    
    /// EN: For the sake of simplicity, the originator's state is
    /// stored inside a single variable.
    ///
    /// RU: Для удобства состояние создателя хранится внутри одной
    /// переменной.
    
    private var state: String
    
    init(state: String) {
        self.state = state
        print("Originator: My initial state is: \(state)")
    }
    
    /// EN: The Originator's business logic may affect its internal state.
    /// Therefore, the client should backup the state before launching methods of
    /// the business logic via the save() method.
    ///
    /// RU: Бизнес-логика Создателя может повлиять на его внутреннее состояние.
    /// Поэтому клиент должен выполнить резервное копирование состояния с помощью
    /// метода save перед запуском методов бизнес-логики.
    
    func doSomething() {
        print("Originator: I'm doing something important.")
        state = generateRandomString()
        print("Originator: and my state has changed to: \(state)")
    }
    
    private func generateRandomString() -> String {
        return String(UUID().uuidString.suffix(4))
    }
    
    /// EN: Saves the current state inside a memento.
    ///
    /// RU: Сохранияет текущее состояние внутри снимка.
    
    func save() -> Memento {
        return ConcreteMemento(state: state)
    }
    
    /// EN: Restores the Originator's state from a memento object.
    ///
    /// RU: Восстанавливает состояние Создателя из объекта снимка.
    
    func restore(memento: Memento) {
        guard let memento = memento as? ConcreteMemento else { return }
        self.state = memento.state
        print("Originator: My state has changed to: \(state)")
    }
}

/// EN: The Memento interface provides a way to retrieve the memento's metadata,
/// such as creation date or name. However, it doesn't expose the Originator's
/// state.
///
/// RU: Интерфейс Снимка предоставляет способ извлечения метаданных снимка, таких
/// как дата создания или название. Однако он не раскрывает состояние Создателя.

protocol Memento {
    
    var name: String { get }
    var date: Date { get }
}

/// EN: The Concrete Memento contains the infrastructure for storing the
/// Originator's state.
///
/// RU: Конкретный снимок содержит инфраструктуру для хранения состояния
/// Создателя.

class ConcreteMemento: Memento {
    
    /// EN: The Originator uses these properties when restoring its state.
    ///
    /// RU: Создатель использует эти свойства, когда восстанавливает своё состояние.
    
    private(set) var state: String
    private(set) var date: Date
    
    init(state: String) {
        self.state = state
        self.date = Date()
    }
    
    /// EN: The rest of the methods are used by the Caretaker to display metadata.
    ///
    /// RU: Остальные методы используются Опекуном для отображения метаданных.
    
    var name: String { return state + " " + date.description.suffix(14).prefix(8) }
}

/// EN: The Caretaker doesn't depend on the Concrete Memento class. Therefore, it
/// doesn't have access to the originator's state, stored inside the memento. It
/// works with all mementos via the base Memento interface.
///
/// RU: Опекун не зависит от класса Конкретного Снимка. Таким образом, он не
/// имеет доступа к состоянию создателя, хранящемуся внутри снимка. Он работает
/// со всеми снимками через базовый интерфейс Снимка.

class Caretaker {
    
    private lazy var mementos = [Memento]()
    private var originator: Originator
    
    init(originator: Originator) {
        self.originator = originator
    }
    
    func backup() {
        print("\nCaretaker: Saving Originator's state...\n")
        mementos.append(originator.save())
    }
    
    func undo() {
        
        guard !mementos.isEmpty else { return }
        let removedMemento = mementos.removeLast()
        
        print("Caretaker: Restoring state to: " + removedMemento.name)
        originator.restore(memento: removedMemento)
    }
    
    func showHistory() {
        print("Caretaker: Here's the list of mementos:\n")
        mementos.forEach({ print($0.name) })
    }
}
