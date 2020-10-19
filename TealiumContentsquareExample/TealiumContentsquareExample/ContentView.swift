//
//  ContentView.swift
//  TealiumContentsquareExample
//
//  Created by Jonathan Wong on 3/9/20.
//  Copyright © 2020 Tealium. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            TabView {
                ScreenView().tabItem {
                    Image(systemName: "rectangle.on.rectangle")
                    Text("Screens")
                }
                TransactionView().tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Transactions")
                }
                DynamicVarView().tabItem {
                    Image(systemName: "greaterthan.square")
                    Text("Dynamic Vars")
                }
                MiscellaneousView().tabItem {
                    Image(systemName: "list.bullet")
                    Text("Miscellaneous")
                }
            }.navigationBarTitle("TealiumContentsquare Demo", displayMode: .inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
