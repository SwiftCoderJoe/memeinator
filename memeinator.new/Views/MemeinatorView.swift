//
//  MemeinatorView.swift
//  MemeinatorView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import AlertToast

struct MemeinatorView: View {
    @EnvironmentObject var keyboardManager: KeyboardManager
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    
    var body: some View {
        VStack(spacing: 0.0) {
            if !keyboardManager.keyboardIsShown {
                Text("Memeinator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LargeDivider()
            }
            
            CopyPasteRegen().environmentObject(settingsViewModel)
            
            Text(settingsViewModel.createFormattedString())
                .font(.system(size: 25))
                .lineLimit(nil)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)
            
            TextField(
                    "Enter memes here...",
                    text: $settingsViewModel.textInput)
                .textFieldStyle(.largeTextField)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textSelection(.disabled)
                .roundedBackground(color: .purple)
                .padding()
                .accentColor(.primary)
            
            // iPhone SE UI cleanup. ugh.
            if !(keyboardManager.keyboardIsShown && (UIDevice.current.type == .iPhoneSE)) {
                VStack(spacing: 0.0) {
                    HStack {
                        Spacer()
                        VStack(spacing: 5.0) {
                            Text("Spacing")
                                .font(.title3)
                                .lineLimit(1)
                            Toggle("", isOn: $settingsViewModel.spacingEnabled)
                                .labelsHidden()
                        }.padding(.vertical)
                        Spacer()
                        VStack(spacing: 5.0) {
                            Text("Casing")
                                .font(.title3)
                                .lineLimit(1)
                            Picker(selection: $settingsViewModel.casingSetting,
                                   label: Text(settingsViewModel.casingSetting.rawValue)
                            ) {
                                ForEach(Casing.allCases) {
                                    Text($0.rawValue)
                                        .font(.system(size: 15))
                                        .tag($0)
                                }
                            }
                            .frame(width: 65, height: 31)
                            .roundedBackground(color: .primary)
                        }.padding(.vertical)
                        Spacer()
                        VStack(spacing: 5.0) {
                            Text("Furryspeak")
                                .font(.title3)
                                .lineLimit(1)
                            Toggle("", isOn: $settingsViewModel.furryspeakEnabled)
                                .labelsHidden()
                        }.padding(.vertical)
                        Spacer()
                    }
                    NavigationLink(destination: MemeSettingsView().environmentObject(settingsViewModel)) {
                        Text("Meme Settings")
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity)
                            .roundedBackground(color: .primary)
                            .padding([.leading, .bottom, .trailing])
                    }
                    
                    
                }
                .roundedBackground(color: .purple)
                .padding()
            }
        }
    }
}

struct MemeinatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selection: .home)
    }
}
