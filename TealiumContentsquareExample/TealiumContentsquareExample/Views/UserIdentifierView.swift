//
//  UserIdentifierView.swift
//  TealiumContentsquareExample
//
//  Created by Sebastian on 4/25/23.
//  Copyright © 2023 Tealium. All rights reserved.
//

import SwiftUI

struct UserIdentifierView: View {
    
    @State private var userId: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter User ID", text: $userId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                self.sendUserIdentifier()
            }) {
                HStack {
                    Image(systemName: "person.crop.circle.badge.checkmark").font(.title)
                    Text("Send User Identifier")
                        .font(.title)
                }.bordered()
            }
            
            Text("Current User ID: \(userId)")
                .font(.subheadline)
                .padding()
                .opacity(userId.isEmpty ? 0 : 1)
        }
        .padding()
    }
}

extension UserIdentifierView {
    func sendUserIdentifier() {
        guard !userId.isEmpty else { return }
        
        TealiumHelper.track(title: "user_identifier", data: [
            "user_identifier": userId
        ])
    }
}

struct UserIdentifierView_Previews: PreviewProvider {
    static var previews: some View {
        UserIdentifierView()
    }
} 