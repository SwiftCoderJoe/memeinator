//
//  CopyPasteRegen.swift
//  memeinator.new
//
//  Created by Kids on 11/5/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI
import AlertToast

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
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
            })
            
            Button(action: {
                settingsViewModel.textInput = UIPasteboard.general.string ?? ""
            }, label: {
                Text("Paste")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
            })
            
            Button(action: {
                settingsViewModel.randomizeState()
            }, label: {
                Text("Refresh")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
            })
            
        }
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