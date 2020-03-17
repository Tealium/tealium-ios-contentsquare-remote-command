//
//  ButtonViewModifier.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/12/20.
//  Copyright © 2020 Jonathan Wong. All rights reserved.
//

import SwiftUI

struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.padding()
            .foregroundColor(.white)
            .background(Color(red: 0, green: 124/255, blue: 193/255))
        .cornerRadius(40)
    }
}

extension View {
    func bordered() -> some View {
        ModifiedContent(
            content: self,
            modifier: ButtonViewModifier())
    }
}

