//
//  ObserverStructure.swift
//  ObserverStructure
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// EN: Observer Design Pattern
///
/// Intent: Define a one-to-many dependency between objects so that when one
/// object changes state, all of its dependents are notified and updated
/// automatically.
///
/// Note that there's a lot of different terms with similar meaning associated
/// with this pattern. Just remember that the Subject is also called the
/// Publisher and the Observer is often called the Subscriber and vice versa.
/// Also the verbs "observe", "listen" or "track" usually mean the same thing.
///
/// RU: Паттерн Наблюдатель
///
/// Назначение: Устанавливает между объектами зависимость «один ко многим» таким
/// образом, что когда изменяется состояние одного объекта, все зависимые от
/// него объекты оповещаются и обновляются автоматически.
///
/// Обратите внимание, что существует множество различных терминов с похожими
/// значениями, связанных с этим паттерном. Просто помните, что Субъекта также
/// называют Издателем, а Наблюдателя часто называют Подписчиком и наоборот.
/// Также глаголы «наблюдать», «слушать» или «отслеживать» обычно означают одно
/// и то же.

class ObserverStructure: XCTestCase {
    
    /// Note: There are a number of ways to implement and use Observer pattern.
    ///
    /// KVO
    /// Here is a great example of how to implement it in a dozen lines of code.
    /// https://www.objc.io/blog/2018/04/24/bindings-with-kvo-and-keypaths/
    ///
    /// NotificationCenter
    /// https://developer.apple.com/documentation/foundation/notificationcenter
    ///
    /// Custom implementation of this pattern.
    
    func test() {
        
        let subject = Subject()
        
        let observer1 = ConcreteObserverA()
        let observer2 = ConcreteObserverB()
        
        subject.attach(observer1)
        subject.attach(observer2)
        
        subject.someBusinessLogic()
        subject.someBusinessLogic()
        subject.detach(observer2)
        subject.someBusinessLogic()
    }
}

protocol Observer: class {
    
    func update(subject: Observable)
}

protocol Observable {

}

/// EN: The Subject owns some important state and notifies observers when the
/// state changes.
///
/// RU: Издатель владеет некоторым важным состоянием и оповещает наблюдателей о
/// его изменениях.

class Subject: Observable
{
    /// For the sake of simplicity, the Subject's state, essential to all subscribers,
    /// is stored in this variable.
    ///
    /// RU: Для удобства в этой переменной хранится состояние Издателя,
    /// необходимое всем подписчикам.
    
    var state: Int = { return Int(arc4random_uniform(10)) }()
    
    /// EN: @var array List of subscribers. In real life, the list of subscribers
    /// can be stored more comprehensively (categorized by event type, etc.).
    ///
    /// RU: @var array Список подписчиков. В реальной жизни список подписчиков
    /// может храниться в более подробном виде (классифицируется по типу события и т.д.)
    
    private lazy var observers = [Observer]()
    
    /// EN: The subscription management methods.
    ///
    /// RU: Методы управления подпиской.
    
    func attach(_ observer: Observer) {
        print("Subject: Attached an observer.\n")
        observers.append(observer)
    }
    
    func detach(_ observer: Observer) {
        if let idx = observers.index(where: { $0 === observer }) {
            observers.remove(at: idx)
            print("Subject: Detached an observer.\n")
        }
    }
    
    /// EN: Trigger an update in each subscriber.
    ///
    /// RU: Запуск обновления в каждом подписчике.
    
    func notify() {
        print("Subject: Notifying observers...\n")
        observers.forEach({ $0.update(subject: self)})
    }
    
    /// EN: Usually, the subscription logic is only a fraction of what a Subject
    /// can really do. Subjects commonly hold some important business logic, that
    /// triggers a notification method whenever something important is about to
    /// happen (or after it).
    ///
    /// RU: Обычно логика подписки – только часть того, что делает Издатель.
    /// Издатели часто содержат некоторую важную бизнес-логику, которая запускает
    /// метод уведомления всякий раз, когда должно произойти что-то важное (или
    /// после этого).
    
    func someBusinessLogic() {
        print("\nSubject: I'm doing something important.\n")
        state = Int(arc4random_uniform(10))
        print("Subject: My state has just changed to: \(state)\n")
        notify()
    }
}

/// EN: Concrete Observers react to the updates issued by the Subject they had
/// been attached to.
///
/// RU: Конкретные Наблюдатели реагируют на обновления, выпущенные Издателем, к
/// которому они прикреплены.

class ConcreteObserverA: Observer {
    
    func update(subject: Observable) {
        
        guard let subject = subject as? Subject else { return }
        
        if subject.state < 3 {
            print("ConcreteObserverA: Reacted to the event.\n")
        }
    }
}

class ConcreteObserverB: Observer {
    
    func update(subject: Observable) {
        guard let subject = subject as? Subject else { return }
        
        if subject.state >= 3 {
            print("ConcreteObserverB: Reacted to the event.\n")
        }
    }
}
