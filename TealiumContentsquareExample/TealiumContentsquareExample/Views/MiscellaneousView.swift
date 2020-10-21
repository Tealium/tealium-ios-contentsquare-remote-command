//
//  MiscellaneousView.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/12/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

import SwiftUI

struct MiscellaneousView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button(action: {
                self.stopTracking()
            }) {
                Text("Stop Tracking")
            }.bordered()
            Button(action: {
                self.resumeTracking()
            }) {
                Text("Resume Tracking")
            }.bordered()
            Button(action: {
                self.forgetMe()
            }) {
                Text("Forget Me")
            }.bordered()
            Button(action: {
                self.optIn()
            }) {
                Text("Opt In")
            }.bordered()
            Button(action: {
                self.optOut()
            }) {
                Text("Opt Out")
            }.bordered()
        }
    }
}

extension MiscellaneousView {
    
    func stopTracking() {
        TealiumHelper.track(title: "stop_tracking", data: nil)
    }
    
    func resumeTracking() {
        TealiumHelper.track(title: "resume_tracking", data: nil)
    }
    
    func forgetMe() {
        TealiumHelper.track(title: "forget_me", data: nil)
    }
    
    func optIn() {
        TealiumHelper.track(title: "opt_in", data: nil)
    }
    
    func optOut() {
        TealiumHelper.track(title: "opt_out", data: nil)
    }
}

struct MiscellaneousView_Previews: PreviewProvider {
    static var previews: some View {
        MiscellaneousView()
    }
}
