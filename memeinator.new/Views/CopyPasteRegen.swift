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
    
    var body: some View {
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
                settingsViewModel.randomizeState()
            }, label: {
                Text("Random")
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
    }
    
}
