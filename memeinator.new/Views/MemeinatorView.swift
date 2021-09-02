//
//  MemeinatorView.swift
//  MemeinatorView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import AlertToast

var numberBeforeIShouldScroll = 690

struct MemeinatorView: View {
    @EnvironmentObject var keyboardManager: KeyboardManager
    @EnvironmentObject var settingsViewModel: SettingsViewModel

    @State var dummyToggle: Bool = false
    @State var toastShowing: Bool = false
    
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
            
            HStack {
                
                Button(action: {
                    UIPasteboard.general.string = settingsViewModel.createFormattedString()
                    toastShowing = true
                }, label: {
                    Text("Copy")
                        .font(.title3)
                        .padding()
                })
                    .frame(maxWidth: .infinity)
                    .roundedBackground(color: .purple)
                
                Button(action: {
                    settingsViewModel.textInput = UIPasteboard.general.string ?? ""
                }, label: {
                    Text("Paste")
                        .font(.title3)
                        .padding()
                })
                    .frame(maxWidth: .infinity)
                    .roundedBackground(color: .purple)
                
                Button(action: {
                    settingsViewModel.textInput = ""
                }, label: {
                    Text("Clear")
                        .font(.title3)
                        .padding()
                })
                    .frame(maxWidth: .infinity)
                    .roundedBackground(color: .purple)
                
            }
            .padding()
            .foregroundColor(.primary)
            .toast(isPresenting: $toastShowing) {
                AlertToast(displayMode: .hud, type: .complete(.green), title: "Copied!")
            }
            
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
                            Toggle("", isOn: $settingsViewModel.isSpaced)
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
                            Toggle("", isOn: $dummyToggle)
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
