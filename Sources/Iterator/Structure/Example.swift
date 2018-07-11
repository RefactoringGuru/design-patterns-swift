//
//  IteratorStructure.swift
//  IteratorStructure
//
//  Created by Maxim Eremenko on 7/11/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

/// EN: Iterator Design Pattern
///
/// Intent: Provide a way to traverse the elements of an aggregate object without
/// exposing its underlying representation.
///
/// RU: Паттерн Итератор
///
/// Назначение: Предоставляет возможность обходить элементы составного объекта,
/// не раскрывая его внутреннего представления.

class IteratorStructureExample: XCTestCase {
    
    /// EN: There's also a built-in interface for collections:
    ///
    /// RU: Также есть встроенный интерфейс для коллекций:
    ///
    /// https://developer.apple.com/documentation/swift/iteratorprotocol
    
    func test() {
        
        /// EN: The client code may or may not know about the Concrete Iterator or
        /// Collection classes, depending on the level of indirection you want to keep in
        /// your program.
        ///
        /// RU: Клиентский код может знать или не знать о Конкретном Итераторе или
        /// классах Коллекций, в зависимости от уровня косвенности, который вы хотите
        /// сохранить в своей программе.
        
        let collection = WordsCollection()
        collection.append("First")
        collection.append("Second")
        collection.append("Third")
        
        print("Straight traversal:")
        
        for item in collection {
            print(item)
        }
        
        print("\nReverse traversal:")
        
        for item in collection.reverseIterator() {
            print(item)
        }
    }
}

/// EN: Concrete Collections provide one or several methods for retrieving fresh
/// iterator instances, compatible with the collection class.
///
/// RU: Конкретные Коллекции предоставляют один или несколько методов для
/// получения новых экземпляров итератора, совместимых с классом коллекции.

class WordsCollection {
    
    fileprivate lazy var items = [String]()
    
    func append(_ item: String) {
        self.items.append(item)
    }
}

extension WordsCollection: Sequence {
    
    func makeIterator() -> CustomIterator {
        return CustomIterator(self)
    }
    
    /// EN: AnySequence and AnyIterator can be used to iterate a collection of any kind.
    
    func reverseIterator() -> AnySequence<String> {
        
        return AnySequence<String> { () -> AnyIterator<String> in
            
            var index = self.items.count - 1
            
            return AnyIterator {
                
                guard index >= 0 else { return nil }
                
                let item = self.items[index]
                index -= 1
                return item
            }
        }
    }
}

class CustomIterator: IteratorProtocol {
    
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
        guard index < collection.items.count else { return nil }
        
        let item = collection.items[index]
        index += 1
        return item
    }
}
