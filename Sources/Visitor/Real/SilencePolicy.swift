//
//  SilencePolicy.swift
//  AbstractFactoryStructure
//
//  Created by Maxim Eremenko on 8/10/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import Foundation

protocol SilencePolicy: CustomStringConvertible {
    
    var isEmailTurnedOn: Bool { get }
    
    var isSMSTurnedOn: Bool { get }
    
    var isPushTurnedOn: Bool { get }
}

class NightPolicyVisitor: SilencePolicy {
    
    var isEmailTurnedOn: Bool { return false }
    
    var isSMSTurnedOn: Bool { return true }
    
    var isPushTurnedOn: Bool { return false }
    
    var description: String { return "Night Policy Visitor" }
}

class DefaultPolicyVisitor: SilencePolicy {
    
    var isEmailTurnedOn: Bool { return true }
    
    var isSMSTurnedOn: Bool { return true }
    
    var isPushTurnedOn: Bool { return true }
    
    var description: String { return "Default Policy Visitor" }
}
