//
//  ContentsquareTrackerTests.swift
//  TealiumContentsquareTests
//
//  Created by Jonathan Wong on 3/12/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import XCTest
@testable import TealiumContentsquare
#if COCOAPODS
#else
    import TealiumRemoteCommands
#endif

class ContentsquareTrackerTests: XCTestCase {

    let contentsquareTracker = MockContentsquareTracker()
    var contentsquareCommand: ContentsquareRemoteCommand!
    var remoteCommand: TealiumRemoteCommand!
    
    override func setUp() {
        contentsquareCommand = ContentsquareRemoteCommand(contentsquareTracker: contentsquareTracker)
        remoteCommand = contentsquareCommand.remoteCommand()
    }

    override func tearDown() {
        
    }

    func testScreenViewCalledWithKey() {
        contentsquareCommand.parseCommands(["sendscreenview"], payload: ["screen_name": "home"])
        XCTAssertEqual(1, contentsquareTracker.sendScreenViewCallCount)
    }

    func testScreenViewNotCalledWitouthKey() {
        contentsquareCommand.parseCommands(["sendscreenview"], payload: ["not_screen_name": "home"])
        XCTAssertEqual(0, contentsquareTracker.sendScreenViewCallCount)
    }

    func testTransactionCalledWithKey() {
        contentsquareCommand.parseCommands(["sendtransaction"], payload: ["transaction": ["price": 1.99,
                                                                                          "currency": "USD"]])
        XCTAssertEqual(1, contentsquareTracker.sendTransactionCallCount)
    }
    
    func testTransactionNotCalledWithoutKey() {
        contentsquareCommand.parseCommands(["sendtransaction"], payload: ["not_transaction": ["price": 1.99,
                                                                                          "currency": Int(1)]])
        XCTAssertEqual(0, contentsquareTracker.sendTransactionCallCount)
    }
    
    func testTransactionCalledWithIdKey() {
        contentsquareCommand.parseCommands(["sendtransaction"], payload: ["transaction": ["price": 1.99,
                                                                                          "currency": "CAD",
                                                                                          "id": "123"]])
        XCTAssertEqual(1, contentsquareTracker.sendTransactionCallCount)
    }
    
    func testTransactionNotCalledWithoutPriceKey() {
        contentsquareCommand.parseCommands(["sendtransaction"], payload: ["not_transaction": ["not_price": 1.99,
                                                                                              "currency": Int(1)]])
        XCTAssertEqual(0, contentsquareTracker.sendTransactionCallCount)
    }
    
    func testTransactionNotCalledWithoutCurrencyKey() {
        contentsquareCommand.parseCommands(["sendtransaction"], payload: ["not_transaction": ["price": 1.99,
                                                                                              "not_currency": Int(1)]])
        XCTAssertEqual(0, contentsquareTracker.sendTransactionCallCount)
    }
    
    func testDynamicVarCalledWithKey() {
        contentsquareCommand.parseCommands(["senddynamicvar"], payload: ["dynamic_var": ["not_price": 1.99,
                                                                                              "currency": Int(1)]])
        XCTAssertEqual(0, contentsquareTracker.sendTransactionCallCount)
    }
    
    func testDynamicVarNotCalledWithoutKey() {
        contentsquareCommand.parseCommands(["senddynamicvar"], payload: ["not_dynamic_var": ["price": 1.99,
                                                                                              "not_currency": Int(1)]])
        XCTAssertEqual(0, contentsquareTracker.sendTransactionCallCount)
    }
}
