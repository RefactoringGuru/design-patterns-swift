/// EN: Observer Design Pattern
///
/// Intent: Lets you define a subscription mechanism to notify multiple objects
/// about any events that happen to the object they're observing.
///
/// Note that there's a lot of different terms with similar meaning associated
/// with this pattern. Just remember that the Subject is also called the
/// Publisher and the Observer is often called the Subscriber and vice versa.
/// Also the verbs "observe", "listen" or "track" usually mean the same thing.
///
/// Swift language has multiple ways of implementing the Observer pattern:
///
/// - KVO. Here is an example of how to implement it in a dozen lines of code:
/// https://www.objc.io/blog/2018/04/24/bindings-with-kvo-and-keypaths/
///
/// - NotificationCenter
/// https://developer.apple.com/documentation/foundation/notificationcenter
///
/// - RxSwift:
/// https://github.com/ReactiveX/RxSwift
///
/// In this example we'll implement a custom observer from scratch.
///
/// RU: Паттерн Наблюдатель
///
/// Назначение: Создаёт механизм подписки, позволяющий одним объектам следить и
/// реагировать на события, происходящие в других объектах.
///
/// Обратите внимание, что существует множество различных терминов с похожими
/// значениями, связанных с этим паттерном. Просто помните, что Субъекта также
/// называют Издателем, а Наблюдателя часто называют Подписчиком и наоборот.
/// Также глаголы «наблюдать», «слушать» или «отслеживать» обычно означают одно
/// и то же.
///
/// Язык Swift имеет несколько способов реализации Наблюдателя. Вот некоторые из
/// них:
///
/// - KVO. Вот замечательный пример того, как можно реализовать паттерн с
/// помощью дюжины строк кода:
/// https://www.objc.io/blog/2018/04/24/bindings-with-kvo-and-keypaths/
///
/// - NotificationCenter:
/// https://developer.apple.com/documentation/foundation/notificationcenter
///
/// - RxSwift:
/// https://github.com/ReactiveX/RxSwift
///
/// В этом примере, однако, мы попробуем реализовать Наблюдатель самостоятельно.

import XCTest

/// EN: The Subject owns some important state and notifies observers when the
/// state changes.
///
/// RU: Издатель владеет некоторым важным состоянием и оповещает наблюдателей о
/// его изменениях.
class Subject {

    /// EN: For the sake of simplicity, the Subject's state, essential to all
    /// subscribers, is stored in this variable.
    ///
    /// RU: Для удобства в этой переменной хранится состояние Издателя,
    /// необходимое всем подписчикам.
    var state: Int = { return Int(arc4random_uniform(10)) }()

    /// EN: @var array List of subscribers. In real life, the list of
    /// subscribers can be stored more comprehensively (categorized by event
    /// type, etc.).
    ///
    /// RU: @var array Список подписчиков. В реальной жизни список подписчиков
    /// может храниться в более подробном виде (классифицируется по типу события
    /// и т.д.)
    private lazy var observers = [Observer]()

    /// EN: The subscription management methods.
    ///
    /// RU: Методы управления подпиской.
    func attach(_ observer: Observer) {
        print("Subject: Attached an observer.\n")
        observers.append(observer)
    }

    func detach(_ observer: Observer) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
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
    /// can really do. Subjects commonly hold some important business logic,
    /// that triggers a notification method whenever something important is
    /// about to happen (or after it).
    ///
    /// RU: Обычно логика подписки – только часть того, что делает Издатель.
    /// Издатели часто содержат некоторую важную бизнес-логику, которая
    /// запускает метод уведомления всякий раз, когда должно произойти что-то
    /// важное (или после этого).
    func someBusinessLogic() {
        print("\nSubject: I'm doing something important.\n")
        state = Int(arc4random_uniform(10))
        print("Subject: My state has just changed to: \(state)\n")
        notify()
    }
}

/// EN: The Observer protocol declares the update method, used by subjects.
///
/// RU: Наблюдатель объявляет метод уведомления, который используют издатели для
/// оповещения.
protocol Observer: AnyObject {

    func update(subject: Subject)
}

/// EN: Concrete Observers react to the updates issued by the Subject they had
/// been attached to.
///
/// RU: Конкретные Наблюдатели реагируют на обновления, выпущенные Издателем, к
/// которому они прикреплены.
class ConcreteObserverA: Observer {

    func update(subject: Subject) {

        if subject.state < 3 {
            print("ConcreteObserverA: Reacted to the event.\n")
        }
    }
}

class ConcreteObserverB: Observer {

    func update(subject: Subject) {

        if subject.state >= 3 {
            print("ConcreteObserverB: Reacted to the event.\n")
        }
    }
}

/// EN: Let's see how it all works together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class ObserverConceptual: XCTestCase {

    func testObserverConceptual() {

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
