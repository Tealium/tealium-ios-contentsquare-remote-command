//
//  ScreenViewDemo.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/9/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import SwiftUI

struct ScreenView: View {
    var body: some View {
        Button(action: {
            self.trackScreenView()
        }) {
            HStack {
                Image(systemName: "rectangle.on.rectangle").font(.title)
                Text("Screen View")
                    .font(.title)
            }.bordered()
        }
    }
}

extension ScreenView {
    func trackScreenView() {
        TealiumHelper.track(title: "screen_title", data: ["screen": "home"])
    }
}

struct ScreenViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}
