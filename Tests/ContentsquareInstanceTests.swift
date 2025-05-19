//
//  ContentsquareInstanceTests.swift
//  TealiumContentsquareTests
//
//  Created by Jonathan Wong on 3/12/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

import XCTest
@testable import TealiumContentsquare
#if COCOAPODS
#else
    import TealiumRemoteCommands
#endif

class ContentsquareInstanceTests: XCTestCase {

    var contentsquareInstance: MockContentsquareInstance!
    var contentsquareCommand: ContentsquareRemoteCommand!
    
    override func setUp() {
        contentsquareInstance = MockContentsquareInstance()
        contentsquareCommand = ContentsquareRemoteCommand(contentsquareInstance: contentsquareInstance)
    }
    
    override func tearDown() {
        contentsquareInstance = nil
        contentsquareCommand = nil
    }
}

// MARK: - Screen View Tests
extension ContentsquareInstanceTests {
    func testScreenViewCalledWithKey() {
        let screenName = "home"
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendscreenview", 
            "screen_name": screenName
        ])
        
        XCTAssertEqual(screenName, contentsquareInstance.lastScreenName)
    }

    func testScreenViewNotCalledWitouthKey() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendscreenview", 
            "not_screen_name": "home"
        ])
        
        XCTAssertNil(contentsquareInstance.lastScreenName)
    }
}

// MARK: - Transaction Tests
extension ContentsquareInstanceTests {
    func testTransactionCalledWithKey() {
        let price = 1.99
        let currency = "USD"
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendtransaction", 
            "transaction": [
                "price": price,
                "currency": currency
            ]
        ])
        
        XCTAssertEqual(price, contentsquareInstance.lastTransactionInfo?.price)
        XCTAssertEqual(currency, contentsquareInstance.lastTransactionInfo?.currency)
        XCTAssertNil(contentsquareInstance.lastTransactionInfo?.transactionId)
    }
    
    func testTransactionCalledWithKeyJSON() {
        let price = 1.99
        let currency = "USD"
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendtransaction", 
            "purchase": [
                "price": price,
                "currency": currency
            ]
        ])
        
        XCTAssertEqual(price, contentsquareInstance.lastTransactionInfo?.price)
        XCTAssertEqual(currency, contentsquareInstance.lastTransactionInfo?.currency)
        XCTAssertNil(contentsquareInstance.lastTransactionInfo?.transactionId)
    }
    
    func testTransactionNotCalledWithoutKey() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendtransaction", 
            "not_transaction": [
                "price": 1.99,
                "currency": Int(1)
            ]
        ])
        
        XCTAssertNil(contentsquareInstance.lastTransactionInfo)
    }
    
    func testTransactionCalledWithIdKey() {
        let price = 1.99
        let currency = "CAD"
        let transactionId = "123"
 
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendtransaction", 
            "transaction": [
                "price": price,
                "currency": currency,
                "transaction_id": transactionId
            ]
        ])
 
        XCTAssertEqual(price, contentsquareInstance.lastTransactionInfo?.price)
        XCTAssertEqual(currency, contentsquareInstance.lastTransactionInfo?.currency)
        XCTAssertEqual(transactionId, contentsquareInstance.lastTransactionInfo?.transactionId)
    }
    
    func testTransactionNotCalledWithoutPriceKey() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendtransaction", 
            "not_transaction": [
                "not_price": 1.99,
                "currency": Int(1)
            ]
        ])
        
        XCTAssertNil(contentsquareInstance.lastTransactionInfo)
    }
    
    func testTransactionNotCalledWithoutCurrencyKey() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendtransaction", 
            "not_transaction": [
                "price": 1.99,
                "not_currency": Int(1)
            ]
        ])
 
        XCTAssertNil(contentsquareInstance.lastTransactionInfo)
    }
}

// MARK: - Dynamic Variable Tests
extension ContentsquareInstanceTests {
    func testDynamicVarCalledWithKey() {
        let dynamicVarData: [String: Any] = ["key1": 1.99, "key2": "value2"]
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "senddynamicvar", 
            "dynamic_var": dynamicVarData
        ])
        
        XCTAssertNotNil(contentsquareInstance.lastDynamicVar)
        XCTAssertEqual(contentsquareInstance.lastDynamicVar!["key1"] as? Double, 1.99)
        XCTAssertEqual(contentsquareInstance.lastDynamicVar!["key2"] as? String, "value2")
    }
    
    func testDynamicVarNotCalledWithoutKey() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "senddynamicvar", 
            "not_dynamic_var": ["key1": 1.99]
        ])
        
        XCTAssertNil(contentsquareInstance.lastDynamicVar)
    }
}

// MARK: - User Identifier Tests
extension ContentsquareInstanceTests {
    func testUserIdentifierCalledWithKey() {
        let userId = "abc123"
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "senduseridentifier", 
            "user_identifier": userId
        ])
        
        XCTAssertEqual(userId, contentsquareInstance.lastUserId)
    }
    
    func testUserIdentifierNotCalledWithoutKey() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "senduseridentifier", 
            "not_user_identifier": "abc123"
        ])
        
        XCTAssertNil(contentsquareInstance.lastUserId)
    }
}

// MARK: - Custom Variables Tests
extension ContentsquareInstanceTests {
    func testCustomVarsCalledWithKey() {
        let screenName = "product_screen"
        let customVar1: [String: Any] = ["index": 0, "name": "category", "value": "electronics"]
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendcustomvars",
            "screen_name": screenName,
            "custom_vars": [customVar1]
        ])
        
        XCTAssertEqual(screenName, contentsquareInstance.lastCustomVarsInfo?.screenName)
        XCTAssertEqual(1, contentsquareInstance.lastCustomVarsInfo?.customVars.count)
        XCTAssertEqual(0, contentsquareInstance.lastCustomVarsInfo?.customVars[0]["index"] as? Int)
        XCTAssertEqual("category", contentsquareInstance.lastCustomVarsInfo?.customVars[0]["name"] as? String)
        XCTAssertEqual("electronics", contentsquareInstance.lastCustomVarsInfo?.customVars[0]["value"] as? String)
    }
    
    func testCustomVarsNotCalledWithoutScreenName() {
        let customVar1: [String: Any] = ["index": 0, "name": "category", "value": "electronics"]
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendcustomvars",
            "not_screen_name": "product_screen",
            "custom_vars": [customVar1]
        ])
        
        XCTAssertNil(contentsquareInstance.lastCustomVarsInfo)
    }
    
    func testCustomVarsNotCalledWithoutCustomVarsArray() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendcustomvars",
            "screen_name": "product_screen",
            "not_custom_vars": []
        ])
        
        XCTAssertNil(contentsquareInstance.lastCustomVarsInfo)
    }
    
    func testCustomVarsNotCalledWithEmptyCustomVarsArray() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendcustomvars",
            "screen_name": "product_screen",
            "custom_vars": []
        ])
        
        XCTAssertNil(contentsquareInstance.lastCustomVarsInfo)
    }
    
    func testCustomVarsWithMultipleVars() {
        let screenName = "product_screen"
        let customVar1: [String: Any] = ["index": 0, "name": "category", "value": "electronics"]
        let customVar2: [String: Any] = ["index": 1, "name": "user_type", "value": "premium"]
        
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "sendcustomvars",
            "screen_name": screenName,
            "custom_vars": [customVar1, customVar2]
        ])
        
        XCTAssertEqual(screenName, contentsquareInstance.lastCustomVarsInfo?.screenName)
        XCTAssertEqual(2, contentsquareInstance.lastCustomVarsInfo?.customVars.count)
        
        // Verify first custom var
        XCTAssertEqual(0, contentsquareInstance.lastCustomVarsInfo?.customVars[0]["index"] as? Int)
        XCTAssertEqual("category", contentsquareInstance.lastCustomVarsInfo?.customVars[0]["name"] as? String)
        XCTAssertEqual("electronics", contentsquareInstance.lastCustomVarsInfo?.customVars[0]["value"] as? String)
        
        // Verify second custom var
        XCTAssertEqual(1, contentsquareInstance.lastCustomVarsInfo?.customVars[1]["index"] as? Int)
        XCTAssertEqual("user_type", contentsquareInstance.lastCustomVarsInfo?.customVars[1]["name"] as? String)
        XCTAssertEqual("premium", contentsquareInstance.lastCustomVarsInfo?.customVars[1]["value"] as? String)
    }
}

// MARK: - Tracking Control Tests
extension ContentsquareInstanceTests {
    func testStopTrackingCalled() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "stoptracking"
        ])
        
        XCTAssertTrue(contentsquareInstance.didStopTracking)
    }
    
    func testResumeTrackingCalled() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "resumetracking"
        ])
        
        XCTAssertTrue(contentsquareInstance.didResumeTracking)
    }
    
    func testForgetMeCalled() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "forgetme"
        ])
        
        XCTAssertTrue(contentsquareInstance.didForgetMe)
    }
    
    func testOptInCalled() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "optin"
        ])
        
        XCTAssertTrue(contentsquareInstance.didOptIn)
    }
    
    func testOptOutCalled() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "optout"
        ])
        
        XCTAssertTrue(contentsquareInstance.didOptOut)
    }
    
    func testMultipleCommands() {
        contentsquareCommand.processRemoteCommand(with: [
            "command_name": "stoptracking,resumetracking,optin"
        ])
        
        XCTAssertTrue(contentsquareInstance.didStopTracking)
        XCTAssertTrue(contentsquareInstance.didResumeTracking)
        XCTAssertTrue(contentsquareInstance.didOptIn)
        XCTAssertFalse(contentsquareInstance.didOptOut)
        XCTAssertFalse(contentsquareInstance.didForgetMe)
    }
}
