import UIKit

protocol AuthView {

    typealias AuthAction = (AuthType) -> ()

    var contentView: UIView { get }
    var authHandler: AuthAction? { get set }

    var description: String { get }
}
