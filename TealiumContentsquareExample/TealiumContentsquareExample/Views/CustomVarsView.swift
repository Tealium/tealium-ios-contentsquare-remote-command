//
//  CustomVarsView.swift
//  TealiumContentsquareExample
//
//  Created by Sebastian on 4/25/23.
//  Copyright © 2023 Tealium. All rights reserved.
//

import SwiftUI

struct CustomVarItem: Identifiable {
    let id = UUID()
    var index: Int
    var name: String
    var value: String
}

struct CustomVarsView: View {
    @State private var screenName: String = ""
    @State private var customVars: [CustomVarItem] = [
        CustomVarItem(index: 0, name: "category", value: "electronics"),
        CustomVarItem(index: 1, name: "user_type", value: "premium")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Screen Name", text: $screenName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                ForEach(customVars.indices, id: \.self) { i in
                    VStack(alignment: .leading) {
                        Text("Custom Variable \(i + 1)")
                            .font(.headline)
                        
                        HStack {
                            Text("Index:")
                            TextField("Index", value: $customVars[i].index, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Name:")
                            TextField("Name", text: $customVars[i].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("Value:")
                            TextField("Value", text: $customVars[i].value)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                
                Button(action: {
                    self.sendCustomVars()
                }) {
                    HStack {
                        Image(systemName: "list.bullet").font(.title)
                        Text("Send Custom Variables")
                            .font(.title)
                    }.bordered()
                }
                .padding()
                .disabled(screenName.isEmpty)
            }
            .padding()
        }
    }
}

extension CustomVarsView {
    func sendCustomVars() {
        guard !screenName.isEmpty else { return }
        
        let varsArray: [[String: Any]] = customVars.map { item in
            return [
                "index": item.index,
                "name": item.name,
                "value": item.value
            ]
        }
        
        TealiumHelper.track(title: "custom_vars", data: [
            "screen": screenName,
            "custom_vars": varsArray
        ])
    }
}

struct CustomVarsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomVarsView()
    }
} 