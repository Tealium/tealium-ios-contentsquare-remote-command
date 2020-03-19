//
//  ContentsquareConstants.swift
//  TealiumContentsquare
//
//  Created by Jonathan Wong on 3/4/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

extension ContentsquareRemoteCommand {
    enum Contentsquare {
        
        enum Commands {
            static let commandKey = "command_name"
            static let separator = ","
            
            static let sendScreenView = "sendscreenview"
            static let sendTransaction = "sendtransaction"
            static let sendDynamicVar = "senddynamicvar"
            static let stopTracking = "stoptracking"
            static let resumeTracking = "resumetracking"
            static let forgetMe = "forgetme"
            static let optIn = "optin"
            static let optOut = "optout"
            
        }
        
        enum ScreenView {
            static let screenName = "screen_name"
        }
        
        enum TransactionProperties {
            static let transaction = "transaction"
            static let price = "price" // required
            static let currency = "currency" // required
            static let transactionId = "transaction_id" // optional
        }
        
        enum DynamicVar {
            static let dynamicVar = "dynamic_var"
        }
    }
}
