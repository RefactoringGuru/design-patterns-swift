//
//  StrategyReal.swift
//  StrategyReal
//
//  Created by Maxim Eremenko on 7/28/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class StrategyReal: XCTestCase {
    
    func test() {
        
        let manager = TravelManager()
        
        let carPrice = manager.price(for: .car(trafficJams: true), distance: 20)
        print("Client: Price of jorney by car: \(carPrice)")
        
        let trainPrice = manager.price(for: .train(luggageWeight: 12.4, isStudent: false),
                                     distance: 20)
        print("Client: Price of jorney by train: \(trainPrice)")
    }
}

class TravelManager {
    
    enum TravelType {
        case car(trafficJams: Bool)
        case train(luggageWeight: Double, isStudent: Bool)
    }
    
    func price(for type: TravelType, distance: Double) -> Double {
        return strategy(for: type).price(for: distance)
    }
    
    private func strategy(for type: TravelType) -> PriceCalculator {
        switch type {
        case .car(let trafficJams):
            return CarPriceCalculator(trafficJams: trafficJams)
        case .train(let luggageWeight, let isStudent):
            return TrainPriceCalculator(luggageWeight: luggageWeight, isStudent: isStudent)
        }
    }
}

protocol PriceCalculator {
    
    func price(for distance: Double) -> Double
}

class CarPriceCalculator: PriceCalculator {
    
    struct Constant {
        static let basePrice = 33.0
        static let distanceFactor = 1.4
    }
    
    private let includeTrafficJams: Bool
    
    init(trafficJams: Bool) {
        self.includeTrafficJams = trafficJams
    }
    
    func price(for distance: Double) -> Double {
        
        let distancePrice = distance * Constant.distanceFactor
        
        var trafficJamsPrice = 0.0
        if includeTrafficJams {
            trafficJamsPrice += distance * 0.1
        }
        
        return Constant.basePrice + distancePrice + trafficJamsPrice
    }
}

class TrainPriceCalculator: PriceCalculator {
    
    struct Constant {
        static let studentDiscount = 0.9
        static let distanceFactor = 1.1
        static let basePrice = 12.0
    }
    
    private let luggageWeight: Double
    private let isStudent: Bool
    
    init(luggageWeight: Double, isStudent: Bool) {
        self.luggageWeight = luggageWeight
        self.isStudent = isStudent
    }
    
    func price(for distance: Double) -> Double {
        
        let distancePrice = distance * Constant.distanceFactor
        let luggagePrice = luggageWeight * 1.3
        
        var result = Constant.basePrice + distancePrice + luggagePrice
        
        if isStudent {
            result *= Constant.studentDiscount
        }
        
        return result
    }
}
