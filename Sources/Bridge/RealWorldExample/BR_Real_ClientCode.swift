//
//  BR_Real_ClientCode.swift
//  RefactoringGuru.Patterns
//
//  Created by Maxim Eremenko on 5/23/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BR_Real_ClientCode: XCTestCase {
    
    func testBridgeReal() {
        
        let newsModel = NewsDomainModel(title: "Bridge example is available for Swift!",
                                        images: [UIImage()])
        
        let appleModel = AppleDomainModel(calories: 47, photo: UIImage())
        let appleAdapter = AppleSharingAdapter(appleModel,
                                              title: "Yeah, I wanna share this Apple!")
        
        let instagram = InstagramSharingService()
        let facebook = FaceBookSharingService()
        
        print("Sharing an Apple model to social networks")
        /// share apple model
        share(content: appleAdapter, using: instagram)
        share(content: appleAdapter, using: facebook)
        
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

struct AppleDomainModel: CustomStringConvertible {
    
    var calories: Int
    var photo: UIImage
    
    var description: String {
        return "Apple Model"
    }
}

struct AppleSharingAdapter: Content {
    
    private let food: AppleDomainModel
    
    var title: String
    
    var images: [UIImage] {
        return [food.photo]
    }
    
    init(_ food: AppleDomainModel, title: String = "") {
        self.food = food
        self.title = title
    }
    
    var description: String {
        return self.food.description
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
