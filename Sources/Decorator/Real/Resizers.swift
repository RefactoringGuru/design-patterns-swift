//
//  Resizers.swift
//  DecoratorReal
//
//  Created by Maxim Eremenko on 6/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

class Resizer: ImageDecorator {
    
    private var xScale: CGFloat = 0
    private var yScale: CGFloat = 0
    private var hasAlpha = false
    
    convenience init(_ editor: ImageEditor, xScale: CGFloat = 0, yScale: CGFloat = 0, hasAlpha: Bool = false) {
        self.init(editor)
        self.xScale = xScale
        self.yScale = yScale
        self.hasAlpha = hasAlpha
    }
    
    required init(_ editor: ImageEditor) {
        super.init(editor)
    }
    
    override func apply() -> UIImage {
        
        let image = super.apply()
        
        let size = image.size.applying(CGAffineTransform(scaleX: xScale, y: yScale))
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage ?? image
    }
    
    override var description: String {
        return "Resizer"
    }
}
