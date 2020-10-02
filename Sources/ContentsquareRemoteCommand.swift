//
//  ContentsquareRemoteCommand.swift
//  TealiumContentsquare
//
//  Created by Jonathan Wong on 3/6/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

import Foundation
#if COCOAPODS
import TealiumSwift
#else
import TealiumCore
import TealiumTagManagement
import TealiumRemoteCommands
#endif

public class ContentsquareRemoteCommand: RemoteCommand {
    
    var contentsquareTracker: ContentsquareTrackable?
    
    public init(contentsquareTracker: ContentsquareTrackable = ContentsquareTracker(), type: RemoteCommandType = .webview) {
        self.contentsquareTracker = contentsquareTracker
        weak var selfWorkaround: ContentsquareRemoteCommand?
        super.init(commandId: Contentsquare.commandId,
                   description: Contentsquare.description,
            type: type,
            completion: { response in
                guard let payload = response.payload else {
                    return
                }
                selfWorkaround?.processRemoteCommand(with: payload)
            })
        selfWorkaround = self
    }
    
    func processRemoteCommand(with payload: [String: Any]) {
        guard let contentsquareTracker = contentsquareTracker,
              let command = payload[Contentsquare.commandKey] as? String else {
                return
        }
        let commands = command.split(separator: Contentsquare.separator)
        let contentsquareCommands = commands.map { command in
            return command.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }

        contentsquareCommands.forEach {
            let command = Contentsquare.Commands(rawValue: $0.lowercased())
            switch command {
            case .sendScreenView:
                guard let screenName = payload[Contentsquare.ScreenView.screenName] as? String else { return }
                contentsquareTracker.sendScreenView(screenName: screenName)
            case .sendTransaction:
                guard let options = payload[Contentsquare.TransactionProperties.transaction] as? [String: Any] else {
                    print("Contentsquare.TransactionProperties.transaction key is missing.")
                    return
                }
                guard let price: Double = options[Contentsquare.TransactionProperties.price] as? Double,
                    let currency: String = options[Contentsquare.TransactionProperties.currency] as? String else { return }
                let transactionId: String? = options[Contentsquare.TransactionProperties.transactionId] as? String
                contentsquareTracker.sendTransaction(price: price, currency: currency, transactionId: transactionId)
            case .sendDynamicVar:
                guard let dynamicVar = payload[Contentsquare.DynamicVar.dynamicVar] as? [String: Any] else { return }
                contentsquareTracker.sendDynamicVar(dynamicVar: dynamicVar)
            case .stopTracking:
                contentsquareTracker.stopTracking()
            case .resumeTracking:
                contentsquareTracker.resumeTracking()
            case .forgetMe:
                contentsquareTracker.forgetMe()
            case .optIn:
                contentsquareTracker.optIn()
            case .optOut:
                contentsquareTracker.optOut()
            default: break
            }
        }
    }
}
