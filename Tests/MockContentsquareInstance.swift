//
//  TealiumContentsquareTests.swift
//  TealiumContentsquareTests
//
//  Created by Jonathan Wong on 3/4/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

import XCTest
@testable import TealiumContentsquare

class MockContentsquareInstance: ContentsquareCommand {

    // Tracking last parameters
    var lastScreenName: String?
    var lastTransactionInfo: (price: Double, currency: String, transactionId: String?)?
    var lastDynamicVar: [String: Any]?
    var lastUserId: String?
    var lastCustomVarsInfo: (screenName: String, customVars: [[String: Any]])?
    
    // Tracking calls
    var didStopTracking = false
    var didResumeTracking = false
    var didOptIn = false
    var didOptOut = false
    
    func sendScreenView(screenName: String, customVars: [[String: Any]]? = nil) {
        lastScreenName = screenName
        if let customVars = customVars, !customVars.isEmpty {
            lastCustomVarsInfo = (screenName: screenName, customVars: customVars)
        }
    }
    
    func sendTransaction(price: Double, currency: String, transactionId: String?) {
        lastTransactionInfo = (price: price, currency: currency, transactionId: transactionId)
    }

    func sendDynamicVar(dynamicVar: [String: Any]) {
        lastDynamicVar = dynamicVar
    }
    
    func sendUserIdentifier(userId: String) {
        lastUserId = userId
    }
    
    func stopTracking() {
        didStopTracking = true
    }
    
    func resumeTracking() {
        didResumeTracking = true
    }
    
    func optIn() {
        didOptIn = true
    }
    
    func optOut() {
        didOptOut = true
    }
}
