//
//  ContentView.swift
//  memeinator3000.new
//
//  Created by Kids on 8/23/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import Introspect

struct ContentView: View {
    // Tells us whether keyboard is shown or hidden
    @StateObject var keyboardManager = KeyboardManager()
    
    // Tells us the current state of Memeinator and formats memes
    @StateObject var settingsViewModel = SettingsViewModel()
    
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
            
            NavigationView {
                KeyboardView()
                    .environmentObject(settingsViewModel)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Label("Keyboard", systemImage: "keyboard")
            }
            .tag(AppPage.keyboard)
            
            NavigationView {
                SettingsView()
                    .environmentObject(settingsViewModel)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Label("More", systemImage: "ellipsis.circle")
            }
            .tag(AppPage.settings)
        }
        .accentColor(.purple)
        .introspectTabBarController { controller in
            let bar = UITabBarAppearance()
            bar.configureWithDefaultBackground()
            controller.tabBar.scrollEdgeAppearance = bar
            
        }
    }
    
    enum AppPage: Hashable {
        case home
        case keyboard
        case settings
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
