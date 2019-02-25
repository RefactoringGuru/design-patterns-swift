import XCTest

/// EN: Iterator Design Pattern
///
/// Intent: Provide a way to traverse the elements of an aggregate object without
/// exposing its underlying representation.
///
/// The client code may or may not know about the Concrete Iterator or
/// Collection classes, depending on the level of indirection you want to keep in
/// your program.
///
/// Example:
/// Both IteratorProtocol and AnyIterator can be used to traverse a collection.
/// Different collection-classes are used to separate iterators.
///
/// RU: Паттерн Итератор
///
/// Назначение: Предоставляет возможность обходить элементы составного объекта,
/// не раскрывая его внутреннего представления.
///
/// Клиентский код может знать или не знать о Конкретном Итераторе или
/// классах Коллекций, в зависимости от уровня косвенности, который вы хотите
/// сохранить в своей программе.
///
/// Пример:
/// IteratorProtocol и AnyIterator могут быть использованы для обхода коллекции.
/// Для разделение итераторов используются разные классы коллекции.

class IteratorStructureExample: XCTestCase {

    /// EN: There's a built-in interface for collections:
    ///
    /// RU: Также есть встроенный интерфейс для коллекций:
    ///
    /// IteratorProtocol: https://developer.apple.com/documentation/swift/iteratorprotocol
    /// AnyIterator: https://developer.apple.com/documentation/swift/anyiterator

    func testIteratorProtocol() {

        let words = WordsCollection()
        words.append("First")
        words.append("Second")
        words.append("Third")

        print("Straight traversal using IteratorProtocol:")
        clientCode(sequence: words)
    }

    func testAnyIterator() {

        let numbers = NumbersCollection()
        numbers.append(1)
        numbers.append(2)
        numbers.append(3)

        print("\nReverse traversal using AnyIterator:")
        clientCode(sequence: numbers)
    }

    func clientCode<S: Sequence>(sequence: S) {

        /// Note: Client does not know the internal representation of a given sequence.
        for item in sequence {
            print(item)
        }
    }
}

class WordsCollection {

    fileprivate lazy var items = [String]()

    func append(_ item: String) {
        self.items.append(item)
    }
}

class NumbersCollection {

    fileprivate lazy var items = [Int]()

    func append(_ item: Int) {
        self.items.append(item)
    }
}

extension WordsCollection: Sequence {

    func makeIterator() -> WordsIterator {
        return WordsIterator(self)
    }
}

extension NumbersCollection: Sequence {

    func makeIterator() -> AnyIterator<Int> {
        var index = self.items.count - 1

        return AnyIterator {
            defer { index -= 1 }
            return index >= 0 ? self.items[index] : nil
        }
    }
}

class WordsIterator: IteratorProtocol {

    /// EN: Concrete Iterators implement various traversal algorithms. These classes
    /// store the current traversal position at all times.
    ///
    /// RU: Конкретные Итераторы реализуют различные алгоритмы обхода. Эти классы
    /// постоянно хранят текущее положение обхода.

    private let collection: WordsCollection
    private var index = 0

    init(_ collection: WordsCollection) {
        self.collection = collection
    }

    func next() -> String? {
        defer { index += 1 }
        return index < collection.items.count ? collection.items[index] : nil
    }
}
