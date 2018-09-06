//
//  Filters.swift
//  DecoratorReal
//
//  Created by Maxim Eremenko on 6/29/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import UIKit

class BaseFilter: ImageDecorator {

    fileprivate var filter: CIFilter?

    init(editor: ImageEditor, filterName: String) {
        self.filter = CIFilter(name: filterName)
        super.init(editor)
    }

    required init(_ editor: ImageEditor) {
        super.init(editor)
    }

    override func apply() -> UIImage {

        let image = super.apply()
        let context = CIContext(options: nil)

        filter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)

        guard let output = filter?.outputImage else { return image }
        guard let coreImage = context.createCGImage(output, from: output.extent) else {
            return image
        }
        return UIImage(cgImage: coreImage)
    }

    override var description: String {
        return "BaseFilter"
    }
}

class BlurFilter: BaseFilter {

    required init(_ editor: ImageEditor) {
        super.init(editor: editor, filterName: "CIGaussianBlur")
    }

    func update(radius: Double) {
        filter?.setValue(radius, forKey: "inputRadius")
    }

    override var description: String {
        return "BlurFilter"
    }
}

class ColorFilter: BaseFilter {

    required init(_ editor: ImageEditor) {
        super.init(editor: editor, filterName: "CIColorControls")
    }

    func update(saturation: Double) {
        filter?.setValue(saturation, forKey: "inputSaturation")
    }

    func update(brightness: Double) {
        filter?.setValue(brightness, forKey: "inputBrightness")
    }

    func update(contrast: Double) {
        filter?.setValue(contrast, forKey: "inputContrast")
    }

    override var description: String {
        return "ColorFilter"
    }
}
