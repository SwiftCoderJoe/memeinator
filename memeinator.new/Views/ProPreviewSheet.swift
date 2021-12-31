//
//  ProPreviewSheet.swift
//  memeinator.new
//
//  Created by Kids on 11/10/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct ProPreviewSheet: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @Binding var isOpen: Bool
    
    let feature: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Memeinator")
                Text("PRO")
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .padding(5)
                    .background(.purple, in: RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                Button(action: {
                    isOpen.toggle()
                }) {
                    Label("Close", systemImage: "plus.circle.fill")
                        .rotationEffect(.degrees(45))
                        .labelStyle(.iconOnly)
                }
            }
            .font(.largeTitle)
            .foregroundColor(.purple)
            .padding()
            LargeDivider()
            
            VStack {
                VStack {
                    Image(systemName: "star.fill")

                    Text("Get \(feature) and More")
                }
                .font(.title)
                .foregroundColor(Color(uiColor: .systemBackground))
                .padding()
                .roundedBackground(color: .purple)

                VStack(alignment: .leading) {
                    Label("More Memeinator Functions", systemImage: "checkmark.circle.fill") // Repeat, emojifier
                    Label("Customize App", systemImage: "checkmark.circle.fill") // Customize quick settings, defaults
                    Label("Customize Keyboard", systemImage: "checkmark.circle.fill") // ^
                    Label("Shortcuts", systemImage: "checkmark.circle.fill") // Shortcuts 0_0
                    Label("All New Features, Forever", systemImage: "checkmark.circle.fill") // Guaranteed!
                }
                .font(.system(size: 15))
                .padding()
                .frame(maxWidth: .infinity)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            
            Text("Only $0.99")
            VStack {
                Button(action: {
                    Task {
                        try await settingsViewModel.store.purchase(.pro)
                        isOpen = false
                    }
                }) {
                    Text("Continue")
                        .frame(maxWidth: 300)
                        .font(.system(size: 15).bold())
                }
                
                .buttonStyle(.borderedProminent)
                .foregroundColor(Color(uiColor: .systemBackground))
                
                Button(action: {
                    Task {
                        try await settingsViewModel.store.restorePurchases()
                        isOpen = false
                    }
                }) {
                    Text("Restore Purchases")
                        .frame(maxWidth: 300)
                        .font(.system(size: 15).bold())
                }
                .buttonStyle(.bordered)
                .foregroundColor(.purple)

            }
            .controlSize(.large)
            .tint(.purple)
            
        }
        // Explicitly set the foreground color because this view is typically called from places where the foreground color is set my default to blue or purple, and we don't want that
        .foregroundColor(.primary)
    }
}


struct ProPreviewSheet_Previews: PreviewProvider {
    @State static var isOpen = true
    
    static var previews: some View {
        ProPreviewSheet(isOpen: $isOpen, feature: "Emojifier")
    }
}
