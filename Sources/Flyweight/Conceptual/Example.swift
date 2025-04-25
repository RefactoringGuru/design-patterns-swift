/// EN: Flyweight Design Pattern
///
/// Intent: Lets you fit more objects into the available amount of RAM by
/// sharing common parts of state between multiple objects, instead of keeping
/// all of the data in each object.
///
/// RU: Паттерн Легковес
///
/// Назначение: Позволяет вместить бóльшее количество объектов в отведённую
/// оперативную память. Легковес экономит память, разделяя общее состояние
/// объектов между собой, вместо хранения одинаковых данных в каждом объекте.

import XCTest

/// EN: The Flyweight stores a common portion of the state (also called
/// intrinsic state) that belongs to multiple real business entities. The
/// Flyweight accepts the rest of the state (extrinsic state, unique for each
/// entity) via its method parameters.
///
/// RU: Легковес хранит общую часть состояния (также называемую внутренним
/// состоянием), которая принадлежит нескольким реальным бизнес-объектам.
/// Легковес принимает  оставшуюся часть состояния (внешнее состояние,
/// уникальное для каждого объекта)  через его параметры метода.
class Flyweight {

    private let sharedState: [String]

    init(sharedState: [String]) {
        self.sharedState = sharedState
    }

    func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState)) state.\n")
    }
}

/// EN: The Flyweight Factory creates and manages the Flyweight objects. It
/// ensures that flyweights are shared correctly. When the client requests a
/// flyweight, the factory either returns an existing instance or creates a new
/// one, if it doesn't exist yet.
///
/// RU: Фабрика Легковесов создает объекты-Легковесы и управляет ими. Она
/// обеспечивает правильное разделение легковесов. Когда клиент запрашивает
/// легковес, фабрика либо возвращает существующий экземпляр, либо создает
/// новый, если он ещё не существует.
class FlyweightFactory {

    private var flyweights: [String: Flyweight]

    init(states: [[String]]) {

        var flyweights = [String: Flyweight]()

        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }

        self.flyweights = flyweights
    }

    /// EN: Returns an existing Flyweight with a given state or creates a new
    /// one.
    ///
    /// RU: Возвращает существующий Легковес с заданным состоянием или создает
    /// новый.
    func flyweight(for state: [String]) -> Flyweight {

        let key = state.key

        guard let foundFlyweight = flyweights[key] else {

            print("FlyweightFactory: Can't find a flyweight, creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        print("FlyweightFactory: Reusing existing flyweight.\n")
        return foundFlyweight
    }

    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        for item in flyweights {
            print(item.key)
        }
    }
}

extension Array where Element == String {

    /// EN: Returns a Flyweight's string hash for a given state.
    ///
    /// RU: Возвращает хеш строки Легковеса для данного состояния.
    var key: String {
        return self.joined()
    }
}


class FlyweightConceptual: XCTestCase {

    func testFlyweight() {

        /// EN: The client code usually creates a bunch of pre-populated
        /// flyweights in the initialization stage of the application.
        ///
        /// RU: Клиентский код обычно создает кучу предварительно заполненных
        /// легковесов на этапе инициализации приложения.

        let factory = FlyweightFactory(states:
        [
            ["Chevrolet", "Camaro2018", "pink"],
            ["Mercedes Benz", "C300", "black"],
            ["Mercedes Benz", "C500", "red"],
            ["BMW", "M5", "red"],
            ["BMW", "X6", "white"]
        ])

        factory.printFlyweights()

        /// ...

        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "M5",
                "red")

        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "X1",
                "red")

        factory.printFlyweights()
    }

    func addCarToPoliceDatabase(
            _ factory: FlyweightFactory,
            _ plates: String,
            _ owner: String,
            _ brand: String,
            _ model: String,
            _ color: String) {

        print("Client: Adding a car to database.\n")

        let flyweight = factory.flyweight(for: [brand, model, color])

        /// EN: The client code either stores or calculates extrinsic state and
        /// passes it to the flyweight's methods.
        ///
        /// RU: Клиентский код либо сохраняет, либо вычисляет внешнее состояние
        /// и передает его методам легковеса.
        flyweight.operation(uniqueState: [plates, owner])
    }
}

