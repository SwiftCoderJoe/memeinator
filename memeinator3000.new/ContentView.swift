//
//  ContentView.swift
//  memeinator3000.new
//
//  Created by Kids on 8/23/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Tells us whether keyboard is shown or hidden
    var keyboardManager = KeyboardManager()
    
    @State var selection: AppPage = .home
    
    var body: some View {
        TabView(selection: $selection) {
            MemeinatorView()
                .environmentObject(keyboardManager)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(AppPage.home)
            
            KeyboardView()
                .tabItem {
                    Label("Keyboard", systemImage: "keyboard")
                }
                .tag(AppPage.keyboard)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(AppPage.settings)
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
