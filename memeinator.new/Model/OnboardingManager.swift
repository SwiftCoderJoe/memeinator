//
//  OnboardingManager.swift
//
//  Created by Joe Cardenas on 7/21/22.
//

import Foundation

/// A simple ObservableObject that saves a value indicating if the onboarding process has been completed.
class OnboardingManager: ObservableObject {
    /// Marks if the onboarding process is complete. False by default, and should be true for the rest of the app.
    @Published(key: "memeinator-settings.onboarding.completed") var onboardingCompleted = false
}
