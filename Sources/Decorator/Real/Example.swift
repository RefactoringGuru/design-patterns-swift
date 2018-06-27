//
//  DecoratorReal.swift
//  DecoratorReal
//
//  Created by Maxim Eremenko on 6/22/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class DecoratorRealExample: XCTestCase {
    
    func testDecoratorReal() {
        
        let image = UIImage()
        
        let blurFilter = BlurFilter()
        blurFilter.update(image: image)
        blurFilter.update(intencity: 0.5)
        
        let colorFilter = ColorFilter()
        colorFilter.update(image: image)
        colorFilter.update(intencity: 0.3)
        
        clientCode(editor: UIKitResizer(blurFilter))
        
        clientCode(editor: CoreGraphicsResizer(colorFilter))
    }
    
    func clientCode(editor: ImageEditor) {
        guard let image = editor.apply() else { return }
        print(image)
    }
}

protocol ImageEditor {
    
    func apply() -> UIImage?
}
