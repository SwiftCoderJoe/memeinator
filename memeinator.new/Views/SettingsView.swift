//
//  SettingsView.swift
//  SettingsView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    
    var body: some View {
        VStack(spacing: 0.0) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            LargeDivider()
            
            Form {
                Section(header:
                    Text("Settings")
                ) {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(appVersion ?? "Unknown")
                    }
                    HStack {
                        Text("App Mode")
                        Spacer()
                        Text(settingsViewModel.store.pro ? "Pro" : "Standard")
                    }
                }
                Section(header:
                    Group {
                        if settingsViewModel.store.pro {
                            Label("Pro", systemImage: "lock")
                                .labelStyle(.titleOnly)
                                .foregroundColor(Color(uiColor: .systemGroupedBackground))
                                .padding(5)
                                .background(.purple, in: RoundedRectangle(cornerRadius: 5))
                        } else {
                            Label("Pro", systemImage: "lock")
                                .foregroundColor(Color(uiColor: .systemGroupedBackground))
                                .padding(5)
                                .background(.purple, in: RoundedRectangle(cornerRadius: 5))
                        }
                    }
                ) {
                    Text("Coming Soon!")
                }
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
