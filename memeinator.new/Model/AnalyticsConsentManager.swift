//
//  AnalyticsConsentManager.swift
//  memeinator.new
//
//  Created by Kids on 7/23/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import FirebaseAnalytics
import FirebaseCrashlytics

class AnalyticsConsentManager: ObservableObject {
    // In theory its not necessary that we set analyticsCollectionEnabled every time, but it feels like a good idea here to make sure consentGiven and analyticsCollectionEnabled do not get out of sync. Especially if the app is reinstalled.
    init() {
        Analytics.setAnalyticsCollectionEnabled(consentGiven)
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(consentGiven)
    }
    
    // Stored value that tracks if Google/Firebase Analytics is enabled. Defaults to false.
    @Published(key: "memeinator-settings.analytics-consent.consent-given")
    var consentGiven = false {
        didSet {
            Analytics.setAnalyticsCollectionEnabled(consentGiven)
            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(consentGiven)
        }
    }
}
