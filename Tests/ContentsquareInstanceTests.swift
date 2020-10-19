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

    let contentsquareInstance = MockContentsquareInstance()
    var contentsquareCommand: ContentsquareRemoteCommand!
    
    override func setUp() {
        contentsquareCommand = ContentsquareRemoteCommand(contentsquareInstance: contentsquareInstance)
    }

    func testScreenViewCalledWithKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendscreenview", "screen_name": "home"])
        XCTAssertEqual(1, contentsquareInstance.sendScreenViewCallCount)
    }

    func testScreenViewNotCalledWitouthKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendscreenview", "not_screen_name": "home"])
        XCTAssertEqual(0, contentsquareInstance.sendScreenViewCallCount)
    }

    func testTransactionCalledWithKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendtransaction", "transaction": ["price": 1.99,
                                                                                          "currency": "USD"]])
        XCTAssertEqual(1, contentsquareInstance.sendTransactionCallCount)
    }
    
    func testTransactionCalledWithKeyJSON() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendtransaction", "purchase": ["price": 1.99,
                                                                                          "currency": "USD"]])
        XCTAssertEqual(1, contentsquareInstance.sendTransactionCallCount)
    }
    
    func testTransactionNotCalledWithoutKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendtransaction", "not_transaction": ["price": 1.99,
                                                                                          "currency": Int(1)]])
        XCTAssertEqual(0, contentsquareInstance.sendTransactionCallCount)
    }
    
    func testTransactionCalledWithIdKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendtransaction", "transaction": ["price": 1.99,
                                                                                          "currency": "CAD",
                                                                                          "id": "123"]])
        XCTAssertEqual(1, contentsquareInstance.sendTransactionCallCount)
    }
    
    func testTransactionNotCalledWithoutPriceKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendtransaction", "not_transaction": ["not_price": 1.99,
                                                                                              "currency": Int(1)]])
        XCTAssertEqual(0, contentsquareInstance.sendTransactionCallCount)
    }
    
    func testTransactionNotCalledWithoutCurrencyKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "sendtransaction", "not_transaction": ["price": 1.99,
                                                                                              "not_currency": Int(1)]])
        XCTAssertEqual(0, contentsquareInstance.sendTransactionCallCount)
    }
    
    func testDynamicVarCalledWithKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "senddynamicvar", "dynamic_var": ["not_price": 1.99,
                                                                                              "currency": Int(1)]])
        XCTAssertEqual(0, contentsquareInstance.sendTransactionCallCount)
    }
    
    func testDynamicVarNotCalledWithoutKey() {
        contentsquareCommand.processRemoteCommand(with: ["command_name": "senddynamicvar", "not_dynamic_var": ["price": 1.99,
                                                                                              "not_currency": Int(1)]])
        XCTAssertEqual(0, contentsquareInstance.sendTransactionCallCount)
    }
}
