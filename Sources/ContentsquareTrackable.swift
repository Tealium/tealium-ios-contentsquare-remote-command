//
//  ContentsquareTrackable.swift
//  TealiumContentsquare
//
//  Created by Jonathan Wong on 3/6/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import Foundation

public protocol ContentsquareTrackable {
    func sendScreenView(screenName: String)
    
    func sendTransaction(price: Double, currency: Int, transactionId: String?)
    
    func sendDynamicVar(dynamicVar: [String: Any])
    
    func stopTracking()
    func resumeTracking()
    func forgetMe()
    func optIn()
    func optOut()

}
