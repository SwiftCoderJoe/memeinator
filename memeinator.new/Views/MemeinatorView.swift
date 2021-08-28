//
//  MemeinatorView.swift
//  MemeinatorView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

var numberBeforeIShouldScroll = 690

struct MemeinatorView: View {
    @EnvironmentObject var keyboardManager: KeyboardManager
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @State var enteredText: String = ""
    @State var dummyToggle: Bool = false
    
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
                    
                }, label: {
                    Text("Copy")
                        .font(.title3)
                        .padding()
                })
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.purple)
                    }
                
                Button(action: {
                    
                }, label: {
                    Text("Paste")
                        .font(.title3)
                        .padding()
                })
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.purple)
                    }
                
                Button(action: {
                    
                }, label: {
                    Text("Clear")
                        .font(.title3)
                        .padding()
                })
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.purple)
                    }
                
            }
            .padding()
            .foregroundColor(.primary)
            
            Text(settingsViewModel.createFormattedString())
                .font(.system(size: 25))
                //.font(.system(size: 30))
                //.minimumScaleFactor(0.05)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)
            
            TextField (
                    "Enter memes here...",
                    text: $settingsViewModel.textInput,
                    onCommit: {
                        
                    })
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.purple)
                }
                .padding()
            
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
                            Toggle("", isOn: $dummyToggle)
                                .labelsHidden()
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
                    
                    Button(action: {
                        // do something lol
                    }, label: {
                        Text("Meme Settings")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                    })
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.primary))
                        .padding([.leading, .bottom, .trailing])
                    
                }
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.purple)
                }
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
