//
//  BRRealExample.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/23/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BridgeRealExample: XCTestCase {
    
    func testBridgeReal() {
        
        let newsModel = NewsDomainModel(
            title: "Bridge example is available for Swift!",
            images: [UIImage()])
        
        let foodModel = FoodDomainModel(
            title: "Yeah, I wanna share this Apple!",
            images: [UIImage(), UIImage()],
            calories: 47)
        
        let instagram = InstagramSharingService()
        let facebook = FaceBookSharingService()
        
        print("Sharing an Food model to social networks")
        /// share apple model
        share(content: foodModel, using: instagram)
        share(content: foodModel, using: facebook)
        
        print("Sharing a News model to social networks")
        /// share news model
        share(content: newsModel, using: instagram)
        share(content: newsModel, using: facebook)
    }
    
    func share(content: Content, using service: SharingService) {
        service.share(content: content)
    }
}

protocol SharingService {
    
    /// Abstraction
    func share(content: Content)
}

protocol AuthService {
    
    func logIn(email: String, password: String)
    func signUp(email: String, password: String)
}

///TODO:
protocol SocialUI {
    
    func logIn()
    func signUp()
}

class TeacherViewController: UIViewController, SocialUI {
    
    func logIn() {
        service?.logIn(email: email, password: password)
    }
    
    func signUp() {
        service?.signUp(email: email, password: password)
    }
    
    var email: String {
        /// Read an email from a text filed
        return "TeacherScreenEmail"
    }
    
    var password: String {
        /// Read a password from a text filed
        return "TeacherScreenPassword"
    }
}

class StudentViewController: UIViewController {
    
    var email: String {
        /// Read an email from a text filed
        return "StudentScreenEmail"
    }
    
    var password: String {
        /// Read a password from a text filed
        return "StudentScreenPassword"
    }
}

protocol Content: CustomStringConvertible {
    
    /// Implementation
    var title: String { get }
    var images: [UIImage] { get }
}

/// Models
struct NewsDomainModel: Content {
    
    var title: String
    var images: [UIImage]
    
    var description: String {
        return "News Model"
    }
}

struct FoodDomainModel: Content {
    
    var title: String
    var images: [UIImage]
    var calories: Int
    
    var description: String {
        return "Apple Model"
    }
}

/// Services
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
