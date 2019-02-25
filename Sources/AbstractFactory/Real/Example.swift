import XCTest

class AbstractFactoryRealExample: XCTestCase {

    func testFactoryMethod_Real() {

        #if teacherMode
            let clientCode = ClientCode(factoryType: StudentAuthViewFactory.self)
        #else
            let clientCode = ClientCode(factoryType: TeacherAuthViewFactory.self)
        #endif

        /// Present LogIn flow
        clientCode.presentLogin()
        print("Login screen has been presented")

        /// Present SignUp flow
        clientCode.presentSignUp()
        print("Sign up screen has been presented")
    }
}

private class ClientCode {

    private var currentController: AuthViewController?

    private lazy var navigationController: UINavigationController = {
        guard let vc = currentController else { return UINavigationController() }
        return UINavigationController(rootViewController: vc)
    }()

    private let factoryType: AuthViewFactory.Type

    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }

    ///MARK: - Presentation

    func presentLogin() {
        let controller = factoryType.authController(for: .login)
        navigationController.pushViewController(controller, animated: true)
    }

    func presentSignUp() {
        let controller = factoryType.authController(for: .signUp)
        navigationController.pushViewController(controller, animated: true)
    }

    /// Other methods...
}
