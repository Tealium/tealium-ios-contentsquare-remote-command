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
import TealiumRemoteCommands
#endif

public class ContentsquareRemoteCommand: RemoteCommand {
    
    var contentsquareInstance: ContentsquareCommand?

    override public var version: String? {
        return ContentsquareConstants.version
    }

    public init(contentsquareInstance: ContentsquareCommand = ContentsquareInstance(), type: RemoteCommandType = .webview) {
        self.contentsquareInstance = contentsquareInstance
        weak var weakSelf: ContentsquareRemoteCommand?
        super.init(commandId: ContentsquareConstants.commandId,
                   description: ContentsquareConstants.description,
            type: type,
            completion: { response in
                guard let payload = response.payload else {
                    return
                }
                weakSelf?.processRemoteCommand(with: payload)
            })
        weakSelf = self
    }
    
    func processRemoteCommand(with payload: [String: Any]) {
        guard let contentsquareInstance = contentsquareInstance,
              let command = payload[ContentsquareConstants.commandKey] as? String else {
                return
        }
        let commands = command.split(separator: ContentsquareConstants.separator)
        let contentsquareCommands = commands.map { command in
            return command.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }

        contentsquareCommands.forEach {
            let command = ContentsquareConstants.Commands(rawValue: $0.lowercased())
            switch command {
            case .sendScreenView:
                guard let screenName = payload[ContentsquareConstants.ScreenView.screenName] as? String else { return }
                contentsquareInstance.sendScreenView(screenName: screenName)
            case .sendTransaction:
                var options = [String: Any]()
                if let transaction = payload[ContentsquareConstants.TransactionProperties.transaction] as? [String: Any] {
                    options = transaction
                } else if let purchase = payload[ContentsquareConstants.TransactionProperties.purchase] as? [String: Any] {
                    options = purchase
                }
                guard let price: Double = options[ContentsquareConstants.TransactionProperties.price] as? Double,
                    let currency: String = options[ContentsquareConstants.TransactionProperties.currency] as? String else { return }
                let transactionId: String? = options[ContentsquareConstants.TransactionProperties.transactionId] as? String
                contentsquareInstance.sendTransaction(price: price, currency: currency, transactionId: transactionId)
            case .sendDynamicVar:
                guard let dynamicVar = payload[ContentsquareConstants.DynamicVar.dynamicVar] as? [String: Any] else { return }
                contentsquareInstance.sendDynamicVar(dynamicVar: dynamicVar)
            case .stopTracking:
                contentsquareInstance.stopTracking()
            case .resumeTracking:
                contentsquareInstance.resumeTracking()
            case .forgetMe:
                contentsquareInstance.forgetMe()
            case .optIn:
                contentsquareInstance.optIn()
            case .optOut:
                contentsquareInstance.optOut()
            default: break
            }
        }
    }
}
