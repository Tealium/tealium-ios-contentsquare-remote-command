//
//  DynamicVarView.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/11/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import SwiftUI

struct DynamicVarView: View {
    
    @State private var keyForString: String = ""
    @State private var valueForString: String = ""
    @State private var keyForNumber: String = ""
    @State private var valueForNumber: String = ""
    
    var body: some View {
        VStack {
            DynamicItemVarView(key: $keyForString, value: $valueForString)
                .padding(.vertical)
            DynamicItemVarView(key: $keyForNumber, value: $valueForNumber)
                .padding(.vertical)
            Button(action: {
                self.trackDynamicVar(keyString: self.keyForString, valueString: self.valueForString, keyNumber: self.keyForNumber, valueNumber: self.valueForNumber)
            }) {
                HStack {
                    Image(systemName: "greaterthan.square").font(.title)
                    Text("Dynamic Var")
                        .font(.title)
                }.bordered()
            }
        }.padding(.horizontal)
    }
}

extension DynamicVarView {
    func trackDynamicVar(keyString: String,
                         valueString: String,
                         keyNumber: String,
                         valueNumber: String) {
        guard let intValue = Int(valueNumber) else {
            TealiumHelper.track(title: "dynamic_var", data:
            ["dynamic_var": [
                keyString: valueString
                ]])
            return
        }
        TealiumHelper.track(title: "dynamic_var", data:
        ["dynamic_var": [
            keyString: valueString,
            keyNumber: intValue]])
    }
}

struct DynamicVarView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicVarView()
    }
}
