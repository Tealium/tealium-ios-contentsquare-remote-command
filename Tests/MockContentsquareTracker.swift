//
//  TealiumContentsquareTests.swift
//  TealiumContentsquareTests
//
//  Created by Jonathan Wong on 3/4/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

import XCTest
@testable import TealiumContentsquare

class MockContentsquareTracker: ContentsquareTrackable {

    var sendScreenViewCallCount = 0
    var sendTransactionCallCount = 0
    var sendDynamicVarCallCount = 0
    var stopTrackingCallCount = 0
    var resumeTrackingCallCount = 0
    var forgetMeCallCount = 0
    var optInCallCount = 0
    var optOutCallCount = 0
    
    func sendScreenView(screenName: String) {
        sendScreenViewCallCount = 1
    }
    
    func sendTransaction(price: Double, currency: String, transactionId: String?) {
        sendTransactionCallCount = 1
    }

    func sendDynamicVar(dynamicVar: [String: Any]) {
        sendDynamicVarCallCount = 1
    }
    
    func stopTracking() {
        stopTrackingCallCount = 1
    }
    
    func resumeTracking() {
        resumeTrackingCallCount = 1
    }
    
    func forgetMe() {
        forgetMeCallCount = 1
    }
    
    func optIn() {
        optInCallCount = 1
    }
    
    func optOut() {
        optOutCallCount = 1
    }
    
}
