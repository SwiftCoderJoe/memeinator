//
//  AnalyticsConsentView.swift
//
//  Created by Joe Cardenas on 7/26/22.
//

import Foundation
import SwiftUI

/// Allows the user to decide if they would like analytics data gathered or not.
///
/// Presented by OnboardingView. It is unlikely that this would need to be presented anywhere else.
struct AnalyticsConsentView: View {
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
                Text("Memeinator uses Google Analytics. Google Analytics helps us understand how we can improve Memeinator. We understand that not everybody likes Google Analytics, so you can disable it if you'd like. You can always change this later in settings.")
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
