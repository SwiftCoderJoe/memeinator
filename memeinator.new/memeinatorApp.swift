//
//  memeinator3000_newApp.swift
//  memeinator3000.new
//
//  Created by Kids on 8/23/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import FirebaseCore

@main
struct MemeinatorApp: App {
    init() {
        FirebaseApp.configure()
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
