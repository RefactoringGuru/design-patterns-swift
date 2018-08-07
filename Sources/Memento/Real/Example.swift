//
//  MementoReal.swift
//  MementoReal
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class MementoReal: XCTestCase {
    
    /// State and Command are often used together when the previous state
    /// of the object should be restored in case of failure of some operation.
    ///
    /// Note: UndoManager can be used as an alternative.
    
    func test() {
        
        let textView = UITextView()
        let careTaker = CareTaker(textView)
        
        textView.text = "First Change"
        careTaker.save()
        
        textView.text = "Second Change"
        careTaker.save()
        
        textView.text = (textView.text ?? "") + " & Third Change"
        textView.textColor = .red
        careTaker.save()
        
        print(careTaker)
        
        print("Client: Perform Undo operation 2 times\n")
        careTaker.undo()
        careTaker.undo()
        
        print(careTaker)
    }
}

class CareTaker: CustomStringConvertible {
    
    private lazy var mementos = [Memento]()
    private let textView: UITextView
    
    init(_ textView: UITextView) {
        self.textView = textView
    }
    
    func save() {
        mementos.append(textView.memento)
    }
    
    func undo() {
        guard !mementos.isEmpty else { return }
        textView.restore(with: mementos.removeLast())
    }
    
    var description: String {
        return mementos.reduce("", { $0 + $1.description })
    }
}

protocol Memento: CustomStringConvertible {
    
    var text: String { get }
    var date: Date { get }
}

struct TextViewMemento: Memento {
    
    let text: String
    let date = Date()
    
    let textColor: UIColor?
    let selectedRange: NSRange
    
    var description: String {
        let time = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond],
                                                   from: date)
        let color = String(describing: textColor)
        return "Text: \(text)\n" + "Date: \(time.description)\n"
            + "Color: \(color)\n" + "Range: \(selectedRange)\n\n"
    }
}

extension UITextView {
    
    var memento: Memento {
        return TextViewMemento(text: text,
                               textColor: textColor,
                               selectedRange: selectedRange)
    }
    
    func restore(with memento: Memento) {
        guard let textViewMemento = memento as? TextViewMemento else { return }
        
        text = textViewMemento.text
        textColor = textViewMemento.textColor
        selectedRange = textViewMemento.selectedRange
    }
}
