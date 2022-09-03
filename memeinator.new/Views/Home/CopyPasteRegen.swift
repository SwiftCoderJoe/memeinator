//
//  CopyPasteRegen.swift
//
//  Created by Joe Cardenas on 11/5/21.
//

import Foundation
import SwiftUI
import AlertToast

/// A horizontal stack of three buttons which allow you to copy the generated text, paste text into the meme input, and regenerate randomized portions of text, respectively.
struct CopyPasteRegen: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var toastShowing = false
    @State var proToastShowing = false
    
    var body: some View {
        HStack {
            
            Button(action: {
                Task {
                    if settingsViewModel.proFeature != nil {
                        if settingsViewModel.store.pro {
                            copy()
                        } else {
                            buyPro()
                        }
                    } else {
                        copy()
                    }
                }
            }, label: {
                Text("Copy")
                    .frame(maxWidth: .infinity)
            })
            
            Button(action: {
                settingsViewModel.textInput = UIPasteboard.general.string ?? ""
            }, label: {
                Text("Paste")
                    .frame(maxWidth: .infinity)
            })
            
            Button(action: {
                settingsViewModel.randomizeState()
            }, label: {
                Text("Regen")
                    .frame(maxWidth: .infinity)
            })
            
        }
        .font(.body)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
        .toast(isPresenting: $toastShowing) {
            AlertToast(displayMode: .hud, type: .complete(.green), title: "Copied!")
        }
        .sheet(isPresented: $proToastShowing) {
            ProPreviewSheet(isOpen: $proToastShowing, feature: settingsViewModel.proFeature ?? "")
                .environmentObject(settingsViewModel)
        }
    }
    
    func copy() {
        UIPasteboard.general.string = settingsViewModel.createFormattedString()
        toastShowing = true
    }
    
    func buyPro() {
        proToastShowing = true
    }
    
}
