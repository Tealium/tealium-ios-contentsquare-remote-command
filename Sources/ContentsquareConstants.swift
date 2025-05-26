//
//  ContentsquareConstants.swift
//  TealiumContentsquare
//
//  Created by Jonathan Wong on 3/4/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

public enum ContentsquareConstants {
    
    static let commandId = "contentsquare"
    static let description = "Contentsquare Remote Command"
    static let commandKey = "command_name"
    static let separator: Character = ","
    static let version = "2.4.0"
    
    enum Commands: String {
        case sendScreenView = "sendscreenview"
        case sendTransaction = "sendtransaction"
        case sendDynamicVar = "senddynamicvar"
        case sendUserIdentifier = "senduseridentifier"
        case stopTracking = "stoptracking"
        case resumeTracking = "resumetracking"
        case forgetMe = "forgetme"
        case optIn = "optin"
        case optOut = "optout"
    }
    
    enum ScreenView {
        static let screenName = "screen_name"
    }
    
    enum TransactionProperties {
        static let purchase = "purchase"
        static let transaction = "transaction"
        static let price = "price" // required
        static let currency = "currency" // required
        static let transactionId = "transaction_id" // optional
    }
    
    enum DynamicVar {
        static let dynamicVar = "dynamic_var"
    }
    
    enum UserIdentifier {
        static let userIdentifier = "user_identifier"
    }
    
    enum CustomVars {
        static let customVars = "custom_vars"
        static let indexes = "indexes"
        static let names = "names"
        static let values = "values"
    }
}
