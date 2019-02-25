import UIKit

protocol Component {

    func accept<T: Theme>(theme: T)
}

extension Component where Self: UIViewController {

    func accept<T: Theme>(theme: T) {
        view.accept(theme: theme)
        view.subviews.forEach({ $0.accept(theme: theme) })
    }
}

extension UIView: Component {}
extension UIViewController: Component {}

extension Component where Self: UIView {

    func accept<T: Theme>(theme: T) {

        print("\t\(description): has applied \(theme.description)")

        backgroundColor = theme.backgroundColor
    }
}

extension Component where Self: UILabel {

    func accept<T: LabelTheme>(theme: T) {

        print("\t\(description): has applied \(theme.description)")

        backgroundColor = theme.backgroundColor
        textColor = theme.textColor
    }
}

extension Component where Self: UIButton {

    func accept<T: ButtomTheme>(theme: T) {

        print("\t\(description): has applied \(theme.description)")

        backgroundColor = theme.backgroundColor
        setTitleColor(theme.textColor, for: .normal)
        setTitleColor(theme.highlightedColor, for: .highlighted)
    }
}
