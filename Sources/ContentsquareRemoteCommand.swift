//
//  ContentsquareRemoteCommand.swift
//  TealiumContentsquare
//
//  Created by Jonathan Wong on 3/6/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import Foundation
#if COCOAPODS
import TealiumSwift
#else
import TealiumCore
import TealiumTagManagement
import TealiumRemoteCommands
#endif

public class ContentsquareRemoteCommand {
    
    let contentsquareTracker:
    ContentsquareTrackable
    
    public init(contentsquareTracker:
        ContentsquareTrackable) {
        self.contentsquareTracker =
        contentsquareTracker
    }
    
    public func remoteCommand() -> TealiumRemoteCommand {
        return TealiumRemoteCommand(commandId: "contentsquare",
                                    description: "Contentsquare Remote Command") { response in
                                        let payload = response.payload()
                                        guard let command = payload[Contentsquare.Commands.commandKey] as? String else {
                                            return
                                        }
                                        
                                        let commands = command.split(separator: ",")
                                        let formatted = commands.map { command in
                                            return command.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                                        }
                                        
                                        self.parseCommands(formatted, payload: payload)
        }
    }
    
    func parseCommands(_ commands: [String], payload: [String: Any]) {
        commands.forEach { command in
            let lowercasedCommand = command.lowercased()
            switch lowercasedCommand {
            case Contentsquare.Commands.sendScreenView:
                guard let screenName = payload[Contentsquare.ScreenView.screenName] as? String else { return }
                contentsquareTracker.sendScreenView(screenName: screenName)
            case Contentsquare.Commands.sendTransaction:
                guard let options = payload[Contentsquare.TransactionProperties.transaction] as? [String: Any] else {
                    print("Contentsquare.TransactionProperties.transaction key is missing.")
                    return
                }
                guard let price: Double = options[Contentsquare.TransactionProperties.price] as? Double,
                    let currency: String = options[Contentsquare.TransactionProperties.currency] as? String else { return }
                let transactionId: String? = options[Contentsquare.TransactionProperties.transactionId] as? String
                contentsquareTracker.sendTransaction(price: price, currency: currency, transactionId: transactionId)
            case Contentsquare.Commands.sendDynamicVar:
                guard let dynamicVar = payload[Contentsquare.DynamicVar.dynamicVar] as? [String: Any] else { return }
                contentsquareTracker.sendDynamicVar(dynamicVar: dynamicVar)
            case Contentsquare.Commands.stopTracking:
                contentsquareTracker.stopTracking()
            case Contentsquare.Commands.resumeTracking:
                contentsquareTracker.resumeTracking()
            case Contentsquare.Commands.forgetMe:
                contentsquareTracker.forgetMe()
            case Contentsquare.Commands.optIn:
                contentsquareTracker.optIn()
            case Contentsquare.Commands.optOut:
                contentsquareTracker.optOut()
            default: break
            }
        }
    }
}
