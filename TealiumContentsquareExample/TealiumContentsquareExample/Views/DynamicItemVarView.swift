//
//  DynamicItemVarView.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/11/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import SwiftUI

struct DynamicItemVarView: View {
    @Binding var key: String
    @Binding var value: String
    @State private var hideOutput: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        TextField("Key: ", text: $key, onEditingChanged: { text in
                            self.checkValues(self.key)
                        })
                        TextField("Value: ", text: $value, onEditingChanged: {
                            text in
                            self.checkValues(self.value)
                        })
                    }
                    VStack {
                        if !hideOutput {
                            Text("[\(key): \(value)]")
                        }
                    }
                }
            }
        }
    }
}

extension DynamicItemVarView {
    
    func checkValues(_ text: String) {
        if text.isEmpty {
            hideOutput = true
        } else {
            hideOutput = false
        }
    }
}

struct DynamicItemVarView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicItemVarView(key: .constant("key123"), value: .constant("value456"))
    }
}
