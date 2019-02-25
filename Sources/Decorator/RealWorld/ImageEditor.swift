import UIKit

protocol ImageEditor: CustomStringConvertible {

    func apply() -> UIImage
}

class ImageDecorator: ImageEditor {

    private var editor: ImageEditor

    required init(_ editor: ImageEditor) {
        self.editor = editor
    }

    func apply() -> UIImage {
        print(editor.description + " applies changes")
        return editor.apply()
    }

    var description: String {
        return "ImageDecorator"
    }
}

extension UIImage: ImageEditor {

    func apply() -> UIImage {
        return self
    }

    open override var description: String {
        return "Image"
    }
}
