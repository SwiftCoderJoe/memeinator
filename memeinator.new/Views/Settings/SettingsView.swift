//
//  SettingsView.swift
//  SettingsView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import KeyboardKit

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
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
                
                Section {
                    NavigationLink(
                        destination: SettingsHelp().environmentObject(settingsViewModel)
                    ) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("Help")
                                    .font(.system(size: 25))
                                Text("About, Contact, Refunds")
                                    .font(.system(size: 15, weight: .light))
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: FunctionalitySettings().environmentObject(settingsViewModel)
                    ) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("Settings")
                                    .font(.system(size: 25))
                                Text("Defaults, Maximums, Minimums")
                                    .font(.system(size: 15, weight: .light))
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: FunctionalitySettings().environmentObject(settingsViewModel)
                    ) {
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("Favorites")
                                    .font(.system(size: 25))
                                Text("Easy Access, Defaults")
                                    .font(.system(size: 15, weight: .light))
                            }
                            .foregroundColor(.primary)
                        }
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
    }
}
