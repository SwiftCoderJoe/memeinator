//
//  memeinatorApp.swift
//
//  Created by Joe Cardenas on 8/23/21.
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
