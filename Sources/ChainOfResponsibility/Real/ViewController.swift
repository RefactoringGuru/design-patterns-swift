import UIKit

protocol AuthHandlerSupportable: AnyObject {

    var handler: Handler? { get set }
}

class BaseAuthViewController: UIViewController, AuthHandlerSupportable {

    /// Base class or extensions can be used to implement a base behavior
    var handler: Handler?

    init(handler: Handler) {
        self.handler = handler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class LoginViewController: BaseAuthViewController {

    func loginButtonSelected() {
        print("Login View Controller: User selected Login button")

        let request = LoginRequest(email: "smth@gmail.com", password: "123HardPass")

        if let error = handler?.handle(request) {
            print("Login View Controller: something went wrong")
            print("Login View Controller: Error -> " + (error.errorDescription ?? ""))
        } else {
            print("Login View Controller: Preconditions are successfully validated")
        }
    }
}

class SignUpViewController: BaseAuthViewController {

    func signUpButtonSelected() {
        print("SignUp View Controller: User selected SignUp button")

        let request = SignUpRequest(firstName: "Vasya",
                                    lastName: "Pupkin",
                                    email: "vasya.pupkin@gmail.com",
                                    password: "123HardPass",
                                    repeatedPassword: "123HardPass")

        if let error = handler?.handle(request) {
            print("SignUp View Controller: something went wrong")
            print("SignUp View Controller: Error -> " + (error.errorDescription ?? ""))
        } else {
            print("SignUp View Controller: Preconditions are successfully validated")
        }
    }
}
