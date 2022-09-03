//
//  SettingsView.swift
//
//  Created by Joe Cardenas on 8/24/21.
//

import SwiftUI
import KeyboardKit

/// "More" tab of Memeinator
struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var onboardingManager: OnboardingManager
    @EnvironmentObject var analyticsConsentManager: AnalyticsConsentManager
    
    var body: some View {
        VStack(spacing: 0.0) {
            Heading("Settings")
            
            Form {
                                
                if !settingsViewModel.store.pro {
                    Section {
                        NavigationLink(
                            destination: ProPreviewPage().environmentObject(settingsViewModel)
                        ) {
                            CaptionedIcon(
                                systemName: "star.fill",
                                title: "Memeinator Pro",
                                caption: "Get More Features"
                            )
                        }
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: SettingsHelp()
                            .environmentObject(settingsViewModel)
                            .environmentObject(onboardingManager)
                    ) {
                        CaptionedIcon(
                            systemName: "questionmark.circle.fill",
                            title: "Help",
                            caption: "About, Contact, Refunds"
                        )
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: FunctionalitySettings()
                            .environmentObject(settingsViewModel)
                            .environmentObject(analyticsConsentManager)
                    ) {
                        CaptionedIcon(
                            systemName: "gearshape.fill",
                            title: "Settings",
                            caption: "Defaults, Settings, Analytics"
                        )
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: FavoritesSettings().environmentObject(settingsViewModel)
                    ) {
                        CaptionedIcon(
                            systemName: "bookmark.fill",
                            title: "Favorites",
                            caption: "Easy Access, Defaults"
                        )
                    }
                }
                
            }
            
        }
        .navigationTitle("Settings")
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsViewModel())
            .environmentObject(OnboardingManager())
            .environmentObject(AnalyticsConsentManager())
    }
}
