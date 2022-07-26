//
//  OnboardingView.swift
//  memeinator.new
//
//  Created by Kids on 7/23/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

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
    
private struct AnalyticsConsentView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @EnvironmentObject var analyticsConsentManager: AnalyticsConsentManager
    
    var body: some View {
        VStack {
            Heading("Analytics")
            
            Spacer()
            
            VStack {
                Image(systemName: "chart.bar.xaxis")
                    .font(.system(size: 60))
                    .foregroundColor(.purple)
                Text("Analytics")
                    .font(.system(size: 30))
                Text("Memeinator uses Google Analytics. Google Analytics helps us understand how we can improve Memeinator. We understand that not everybody likes Google Analytics, so you can disable it if you'd like.")
                    .multilineTextAlignment(.center)
            }
            .padding(10)
            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 15))
            .padding()
            
            Spacer()
            
            VStack {
                Button(action: {
                    analyticsConsentManager.consentGiven = true
                    onboardingManager.onboardingCompleted = true
                }) {
                    Text("Enable Analytics")
                        .frame(maxWidth: 300)
                        .font(.system(size: 15).bold())
                }
                
                .buttonStyle(.borderedProminent)
                .foregroundColor(Color(uiColor: .systemBackground))
                
                Button(action: {
                    analyticsConsentManager.consentGiven = false
                    onboardingManager.onboardingCompleted = true
                }) {
                    Text("Disable Analytics")
                        .frame(maxWidth: 300)
                        .font(.system(size: 15).bold())
                }
                .buttonStyle(.bordered)
                .foregroundColor(.purple)
            }
            .controlSize(.large)
            .tint(.purple)
        }
        .navigationBarHidden(true)
    }
}
