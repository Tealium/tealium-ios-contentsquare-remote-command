//
//  TealiumHelper.swift
//  BrazeRemoteCommand
//
//  Created by Jonathan Wong on 5/29/19.
//  Copyright © 2019 Jonathan Wong. All rights reserved.
//

import Foundation
import TealiumSwift
import TealiumContentsquare

class TealiumHelper {
    
    static let shared = TealiumHelper()
    let config = TealiumConfig(account: "tealiummobile",
                               profile: "contentsquare-dev",
                               environment: "qa",
                               datasource: nil)
    
    var tealium: Tealium?
    static var universalData = [String: Any]()
    
    private init() {
        let list = TealiumModulesList(isWhitelist: false,
                                      moduleNames: ["autotracking", "collect", "consentmanager"])
        config.modulesList = list
        config.logLevel = .verbose
        config.shouldUseRemotePublishSettings = true
        config.batchingEnabled = false
        self.tealium?.consentManager()?.setUserConsentStatus(.consented)
        
        tealium = Tealium(config: config) { responses in
            guard let remoteCommands = self.tealium?.remoteCommands() else {
                return
            }
            let contentsquareTracker = ContentsquareTracker()
            let contentsquareCommand = ContentsquareCommand(contentsquareTracker: contentsquareTracker)
            let contentsquareRemoteCommand = contentsquareCommand.remoteCommand()
            remoteCommands.add(contentsquareRemoteCommand)
        }
    }
    
    class func start() {
        _ = TealiumHelper.shared
    }
    
    class func track(title: String, data: [String: Any]?) {
        if let data = data {
            universalData = universalData.merging(data) { _, new in new }
        }
        TealiumHelper.shared.tealium?.track(title: title, data: universalData, completion: nil)
    }
}
