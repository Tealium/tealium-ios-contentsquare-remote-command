//
//  TealiumHelper.swift
//  BrazeRemoteCommand
//
//  Created by Jonathan Wong on 5/29/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import Foundation
import TealiumSwift
import TealiumContentsquare

enum TealiumConfiguration {
    static let account = "tealiummobile"
    static let profile = "contentsquare-dev"
    static let environment = "qa"
}

class TealiumHelper {

    static let shared = TealiumHelper()

    let config = TealiumConfig(account: TealiumConfiguration.account,
        profile: TealiumConfiguration.profile,
        environment: TealiumConfiguration.environment)

    var tealium: Tealium?
    
    static var universalData = [String: Any]()
    
    // JSON Remote Command
    let contentsquareRemoteCommand = ContentsquareRemoteCommand(type: .remote(url: "https://tags.tiqcdn.com/dle/tealiummobile/demo/contentsquare.json"))

    private init() {
        config.shouldUseRemotePublishSettings = false
        config.batchingEnabled = false
        config.remoteAPIEnabled = true
        config.logLevel = .info
        config.dispatchers = [ Dispatchers.RemoteCommands]
        
        config.addRemoteCommand(contentsquareRemoteCommand)
        
        tealium = Tealium(config: config)
    }


    class func start() {
        _ = TealiumHelper.shared
    }

    class func trackView(title: String, data: [String: Any]?) {
        let tealiumView = TealiumView(title, dataLayer: data)
        TealiumHelper.shared.tealium?.track(tealiumView)
    }

    class func track(title: String, data: [String: Any]?) {
        if let data = data {
            universalData = universalData.merging(data) { _, new in new }
        }
        let tealiumEvent = TealiumEvent(title, dataLayer: universalData)
        TealiumHelper.shared.tealium?.track(tealiumEvent)
    }

}
