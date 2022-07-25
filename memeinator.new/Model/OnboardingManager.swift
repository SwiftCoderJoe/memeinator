//
//  OnboardingManager.swift
//  memeinator.new
//
//  Created by Kids on 7/21/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation

class OnboardingManager: ObservableObject {
    @Published(key: "memeinator-settings.onboarding.completed") var onboardingCompleted = false
}
