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
                var customVars: [[String: Any]]?
                if let customVarsArray = payload[ContentsquareConstants.CustomVars.customVars] as? [[String: Any]] {
                    customVars = customVarsArray
                } else if let customVarsFromJSON = payload[ContentsquareConstants.CustomVars.customVars] as? [String: Any] {
                    customVars = customVarsFromArrays(customVarsFromJSON)
                }
                contentsquareInstance.sendScreenView(screenName: screenName, customVars: customVars)
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
            case .sendUserIdentifier:
                guard let userId = payload[ContentsquareConstants.UserIdentifier.userIdentifier] as? String else { return }
                contentsquareInstance.sendUserIdentifier(userId: userId)
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
    
    func customVarsFromArrays(_ payload: [String: Any]) -> [[String: Any]] {
        let customVarArrays = payload.normalizeCustomVarArrays()
        // We assume that all arrays have the same length
        let count = customVarArrays.first?.value.count ?? 0
        var result = Array<[String: Any]>(repeating: [:], count: count)
        
        for i in 0 ..< count {
            for key in customVarArrays.keys {
                if let values = customVarArrays[key], values.count > i {
                    result[i][key] = values[i]
                }
            }
        }
        return result
    }
}

extension Dictionary where Key == String, Value == Any {
    
    func normalizeCustomVarArrays() -> [String: [Any]] {
        self.filter { $0.key == ContentsquareConstants.CustomVars.index || 
                     $0.key == ContentsquareConstants.CustomVars.name || 
                     $0.key == ContentsquareConstants.CustomVars.value }
            .reduce(into: [String: [Any]]()) { result, dictionary in
                result[dictionary.key] = dictionary.value as? [Any] ?? [dictionary.value]
            }
    }
}
