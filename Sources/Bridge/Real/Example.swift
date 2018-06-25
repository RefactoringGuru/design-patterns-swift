//
//  BRRealExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/23/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

private class BridgeRealExample: XCTestCase {
    
    func testBridgeReal() {
        
        print("Pushing Photos View Controller...")
        push(viewController: PhotosViewController())
        
        print()
        
        print("Pushing Feed View Controller...")
        push(viewController: FeedViewController())
    }
    
    func push(viewController: SharingSupportable & Testable) {
        
        let instagram = InstagramSharingService()
        let facebook = FaceBookSharingService()
        
        /// ...setting up a navigation stack...
        
        print("A user selected a 'food' model")
        viewController.accept(service: instagram)
        viewController.userSelectedShareButton(with: foodModel)
        
        viewController.accept(service: facebook)
        viewController.userSelectedShareButton(with: foodModel)
    }
    
    var foodModel: Content {
        return FoodDomainModel(title: "This food is so various and delicious!",
                               images: [UIImage(), UIImage()],
                               calories: 47)
    }
}

protocol SharingSupportable {
    
    /// Abstraction
    func accept(service: SharingService)
}

class PhotosViewController: UIViewController, SharingSupportable, Testable {
    
    fileprivate var sharingService: SharingService?
    
    func accept(service: SharingService) {
        sharingService = service
    }
}

class FeedViewController: UIViewController, SharingSupportable, Testable {
    
    fileprivate var sharingService: SharingService?
    
    func accept(service: SharingService) {
        sharingService = service
    }
}

protocol SharingService {
    
    /// Implementation
    func share(content: Content)
}

class FaceBookSharingService: SharingService {
    
    func share(content: Content) {
        
        /// Use FaceBook API to share a content
        print("\(content) was posted to the Facebook")
    }
}

class InstagramSharingService: SharingService {
    
    func share(content: Content) {
        
        /// Use Instagram API to share a content
        print("\(content) was posted to the Instagram")
    }
}

private protocol Testable {
    
    /// Helps to test view controllers by generating a 'button selection' event
    
    func userSelectedShareButton(with content: Content)
    
    var sharingService: SharingService? { get }
}

extension Testable {
    
    func userSelectedShareButton(with content: Content) {
        sharingService?.share(content: content)
    }
}

protocol Content: CustomStringConvertible {
    
    var title: String { get }
    var images: [UIImage] { get }
}

struct FoodDomainModel: Content {
    
    var title: String
    var images: [UIImage]
    var calories: Int
    
    var description: String {
        return "Food Model"
    }
}
