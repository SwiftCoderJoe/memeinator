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
    
    // Tells us if analytics is enabled or disabled and can enable and disable analytics
    @StateObject var analyticsConsentManager = AnalyticsConsentManager()
    
    // Tells us if the onboarding process has been completed
    @StateObject var onboardingManager = OnboardingManager()
    
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
                    .environmentObject(analyticsConsentManager)
                    .environmentObject(onboardingManager)
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
        .fullScreenCover(isPresented: !$onboardingManager.onboardingCompleted) {
            OnboardingView()
                .environmentObject(onboardingManager)
                .environmentObject(analyticsConsentManager)
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
