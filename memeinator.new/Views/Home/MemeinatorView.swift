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
                Heading(name: "Memeinator")
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
                        settingsViewModel.leftQuickSetting.quickSetting
                            .environmentObject(settingsViewModel)
                        
                        settingsViewModel.centerQuickSetting.quickSetting
                            .environmentObject(settingsViewModel)
                        
                        settingsViewModel.rightQuickSetting.quickSetting
                            .environmentObject(settingsViewModel)
                    }
                }
                .roundedBackground(color: .purple)
                .padding(.horizontal)
            }
            
            NavigationLink(
                destination: MemeSettingsView().environmentObject(settingsViewModel)
            ) {
                HStack {
                    Spacer()
                    Text("Text Settings")
                    Image(systemName: "chevron.right")
                    Spacer()
                }
                .font(.system(size: 15).bold())
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
    }
}

struct MemeinatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selection: .home)
    }
}
