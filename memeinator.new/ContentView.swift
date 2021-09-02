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
    
    // Tells us the current state of Memeinator and formats memes
    var settingsViewModel = SettingsViewModel()
    
    // Current selected tab
    @State var selection: AppPage = .home
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                MemeinatorView()
                    .environmentObject(keyboardManager)
                    .environmentObject(settingsViewModel)
                    .navigationBarHidden(true)
            }
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
