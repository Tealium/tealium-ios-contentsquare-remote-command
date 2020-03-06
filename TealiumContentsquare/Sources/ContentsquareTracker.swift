//
//  ContentsquareTracker.swift
//  TealiumContentsquare
//
//  Created by Jonathan Wong on 3/6/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import Foundation
import ContentsquareModule

public class ContentsquareTracker: ContentsquareTrackable {
    
    func sendScreenView(screenName: String) {
        Contentsquare.send(screenViewWithName: screenName)
    }
    
    func sendTransaction(price: Double, currency: Int, transactionId: String?) {
        guard let currency = Currency(rawValue: currency) else {
            print("Error with currency value.")
            return
        }
        let transaction = CustomerTransaction(id: transactionId, value: Float(price), currency: currency)
        Contentsquare.send(transaction: transaction)
    }
    
    func sendDynamicVar(dynamicVar: [String: Any]) {
        dynamicVar.forEach { key, value in
            if let value = value as? String {
                do {
                    let dynamicVar = try DynamicVar(key: key, value: value)
                    Contentsquare.send(dynamicVar: dynamicVar)
                } catch {
                    print("Error with dynamic variable key: \(key), value: \(value), error: \(error)")
                }
            } else if let value = value as? UInt32 {
                do {
                    let dynamicVar = try DynamicVar(key: key, value: value)
                    Contentsquare.send(dynamicVar: dynamicVar)
                } catch {
                    print("Error with dynamic variable key: \(key), value: \(value), error: \(error)")
                }
            } else {
                print("Incorrect format of value: \(value). Value should be String or UInt32.")
            }
        }
    }
    
    func stopTracking() {
        Contentsquare.stopTracking()
    }
    
    func resumeTracking() {
        Contentsquare.resumeTracking()
    }
    
    func forgetMe() {
        Contentsquare.forgetMe()
    }
    
    func optIn() {
        Contentsquare.optIn()
    }
    
    func optOut() {
        Contentsquare.optOut()
    }
}
