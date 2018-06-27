//
//  Resizers.swift
//  DecoratorReal
//
//  Created by Maxim Eremenko on 6/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

class ImageResizer: ImageEditor {
    
    private var editor: ImageEditor
    
    required init(_ editor: ImageEditor) {
        self.editor = editor
    }
    
    func apply() -> UIImage? {
        return editor.apply()
    }
}

class UIKitResizer: ImageResizer {
    
    override func apply() -> UIImage? {
        let image = super.apply()
        /// TODO ...resize
        return image
    }
}

class CoreGraphicsResizer: ImageResizer {
    
    override func apply() -> UIImage? {
        let image = super.apply()
        /// TODO ...resize
        return image
    }
}
