//
//  ScreenViewDemo.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/9/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

import SwiftUI

struct CustomVarItem: Identifiable {
    let id = UUID()
    var index: Int
    var name: String
    var value: String
}

struct ScreenView: View {
    @State private var screenName: String = "home"
    @State private var showCustomVars: Bool = false
    @State private var customVars: [CustomVarItem] = [
        CustomVarItem(index: 1, name: "category", value: "electronics"),
        CustomVarItem(index: 2, name: "user_type", value: "premium")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TextField("Screen Name", text: $screenName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    self.trackScreenView()
                }) {
                    HStack {
                        Image(systemName: "rectangle.on.rectangle").font(.title)
                        Text("Send Screen View")
                            .font(.title)
                    }.bordered()
                }
                .padding()
                
                Toggle("Include Custom Variables", isOn: $showCustomVars)
                    .padding()
                
                if showCustomVars {
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
                }
            }
            .padding()
        }
    }
}

extension ScreenView {
    func trackScreenView() {
        var data: [String: Any] = ["screen": screenName]
        
        if showCustomVars {
            // Send as separate arrays (for JSON mapping)
            let indexes = customVars.map { $0.index }
            let names = customVars.map { $0.name }
            let values = customVars.map { $0.value }
            
            data["custom_var_indexes"] = indexes
            data["custom_var_names"] = names
            data["custom_var_values"] = values
        }
        
        TealiumHelper.track(title: "screen_title", data: data)
    }
}

extension View {
    func bordered() -> some View {
        self.padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
    }
}
