//
//  OnboardingView.swift
//
//  Created by Joe Cardenas on 7/23/22.
//

import Foundation
import SwiftUI

/// This view guides the user through setting up Analytics Consent. Should be presented on the first run of the app.
struct OnboardingView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @EnvironmentObject var analyticsConsentManager: AnalyticsConsentManager
        
    var body: some View {
        NavigationView {
            VStack {
                Heading("Welcome to Memeinator")
                
                CenteredScrollView {
                    VStack {
                        
                        Spacer()
                        
                        CaptionedIcon(
                            systemName: "paintbrush.pointed.fill",
                            title: "Create",
                            caption: "Use and stack Memeinator's text effects to create funny text"
                        )
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 15))
                        .padding()
                        
                        CaptionedIcon(
                            systemName: "keyboard.fill",
                            title: "Type",
                            caption: "Use the Memeinator Keyboard to type using effects on the fly"
                        )
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 15))
                        .padding()
                        
                        CaptionedIcon(
                            systemName: "star.fill",
                            title: "Memeinator Pro",
                            caption: "Get Memeinator Pro to access even more text effects and features"
                        )
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 15))
                        .padding()
                        
                        Spacer()
                    }
                }
                .introspectScrollView { scrollView in
                    scrollView.alwaysBounceVertical = false
                }
                
                NavigationLink(
                    destination: AnalyticsConsentView()
                        .environmentObject(onboardingManager)
                        .environmentObject(analyticsConsentManager)
                ) {
                    Text("Continue")
                        .frame(maxWidth: 300)
                        .font(.system(size: 15).bold())
                        .foregroundColor(Color(uiColor: .systemBackground))
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.purple)
            }
            .navigationBarHidden(true)
        }
    }
}
