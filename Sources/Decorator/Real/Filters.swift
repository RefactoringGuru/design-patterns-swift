//
//  Filters.swift
//  DecoratorReal
//
//  Created by Maxim Eremenko on 6/27/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

protocol Filter: ImageEditor {
    
    var filter: CIFilter { get set }
    
    func update(intencity: Double)
    func update(image: UIImage)
}

extension Filter {
    
    func update(intencity: Double) {
        if 0...1 ~= intencity {
            filter.setValue(intencity, forKey: kCIInputIntensityKey)
        }
    }
    
    func update(image: UIImage) {
        filter.setValue(image.ciImage, forKey: kCIInputImageKey)
    }
    
    func apply() -> UIImage? {
        
        let context = CIContext(options: nil)
        
        guard let output = filter.outputImage else { return nil }
        guard let coreImage = context.createCGImage(output, from: output.extent) else {
            return nil
        }
        return UIImage(cgImage: coreImage)
    }
}

class BlurFilter: Filter {
    
    lazy var filter = CIFilter(name: "CIGaussianBlur")!
    
    func update(radius: Double) {
        filter.setValue(radius, forKey: "inputRadius")
    }
}

class ColorFilter: Filter {
    
    lazy var filter = CIFilter(name: "CIColorControls")!
    
    func update(saturation: Double) {
        filter.setValue(saturation, forKey: "inputSaturation")
    }
    
    func update(brightness: Double) {
        filter.setValue(brightness, forKey: "inputBrightness")
    }
    
    func update(contrast: Double) {
        filter.setValue(contrast, forKey: "inputContrast")
    }
}

