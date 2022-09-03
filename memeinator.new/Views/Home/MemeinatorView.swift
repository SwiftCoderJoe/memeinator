//
//  MemeinatorView.swift
//
//  Created by Joe Cardenas on 8/24/21.
//

import SwiftUI
import AlertToast

/// The main homepage of the app. "Home" tab.
struct MemeinatorView: View {
    @EnvironmentObject var keyboardManager: KeyboardManager
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    
    var body: some View {
        
        // I've heard some people saying that putting declarations like this in `body` isn't good... I cannot think of a good reason why you wouldn't. This is exactly what I need, afaik. Do more research.
        let formattedString = settingsViewModel.createFormattedString()
        
        VStack(spacing: 0.0) {
            if !keyboardManager.keyboardIsShown {
                Heading("Memeinator")
            }
            
            CopyPasteRegen().environmentObject(settingsViewModel)
            
            Text(formattedString)
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
                    
                    HStack(spacing: 0) {
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
                destination: MemeSettingsView(formattedString: formattedString)
                                .environmentObject(settingsViewModel)
            ) {
                HStack {
                    Spacer()
                    Text("Text Settings")
                    Image(systemName: "chevron.right")
                    Spacer()
                }
                .font(.body.bold())
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
    }
}

struct MemeinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MemeinatorView()
            .environmentObject(SettingsViewModel())
            .environmentObject(KeyboardManager())
    }
}
