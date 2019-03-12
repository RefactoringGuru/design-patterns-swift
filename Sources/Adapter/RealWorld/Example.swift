import XCTest
import UIKit

/// Adapter Design Pattern
///
/// Intent: Convert the interface of a class into the interface clients expect.
/// Adapter lets classes work together that couldn't work otherwise because of
/// incompatible interfaces.

class AdapterRealWorld: XCTestCase {

    /// Example. Let's assume that our app perfectly works with Facebook
    /// authorization. However, users ask you to add sign in via Twitter.
    ///
    /// Unfortunately, Twitter SDK has a different authorization method.
    ///
    /// Firstly, you have to create the new protocol 'AuthService' and insert
    /// the authorization method of Facebook SDK.
    ///
    /// Secondly, write an extension for Twitter SDK and implement methods of
    /// AuthService protocol, just a simple redirect.
    ///
    /// Thirdly, write an extension for Facebook SDK. You should not write any
    /// code at this point as methods already implemented by Facebook SDK.
    ///
    /// It just tells a compiler that both SDKs have the same interface.

    func testAdapterRealWorld() {

        print("Starting an authorization via Facebook")
        startAuthorization(with: FacebookAuthSDK())

        print("Starting an authorization via Twitter.")
        startAuthorization(with: TwitterAuthSDK())
    }

    func startAuthorization(with service: AuthService) {

        /// The current top view controller of the app
        let topViewController = UIViewController()

        service.presentAuthFlow(from: topViewController)
    }
}

protocol AuthService {

    func presentAuthFlow(from viewController: UIViewController)
}

class FacebookAuthSDK {

    func presentAuthFlow(from viewController: UIViewController) {
        /// Call SDK methods and pass a view controller
        print("Facebook WebView has been shown.")
    }
}

class TwitterAuthSDK {

    func startAuthorization(with viewController: UIViewController) {
        /// Call SDK methods and pass a view controller
        print("Twitter WebView has been shown. Users will be happy :)")
    }
}

extension TwitterAuthSDK: AuthService {

    /// This is an adapter
    ///
    /// Yeah, we are able to not create another class and just extend an
    /// existing one

    func presentAuthFlow(from viewController: UIViewController) {
        print("The Adapter is called! Redirecting to the original method...")
        self.startAuthorization(with: viewController)
    }
}

extension FacebookAuthSDK: AuthService {
    /// This extension just tells a compiler that both SDKs have the same
    /// interface.
}
