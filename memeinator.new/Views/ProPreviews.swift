//
//  ProPreviewSheet.swift
//
//  Created by Joe Cardenas on 11/10/21.
//

import Foundation
import SwiftUI

/// Guides users through purchasing Memeinator pro, including a note about the feature they attempted to use.
struct ProPreviewSheet: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @Binding var isOpen: Bool
    
    let feature: String
    
    var body: some View {
        GenericProPreview(text: "Get \(feature) and More", close: {
            isOpen = false
        })
        .environmentObject(settingsViewModel)
            
        // Explicitly set the foreground color because this view is typically called from places where the foreground color is set my default to blue or purple, and we don't want that
        .foregroundColor(.primary)
    }
}

struct ProPreviewPage: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GenericProPreview(text: "Get More with Memeinator Pro", close: {
            self.presentationMode.wrappedValue.dismiss()
        })
        .environmentObject(settingsViewModel)
        .padding(.bottom)
        .navigationBarHidden(true)
    }
}

struct GenericProPreview: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    let text: String
    
    let close: () -> Void
    
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
                    close()
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
                LargeMessage(iconName: "star.fill", message: text)

                VStack(alignment: .leading) {
                    Label("More Memeinator Functions", systemImage: "checkmark.circle.fill") // Repeat, emojifier
                    Label("Customize App", systemImage: "checkmark.circle.fill") // Customize quick settings, defaults
                    Label("Customize Keyboard", systemImage: "checkmark.circle.fill") // ^
                    Label("Shortcuts", systemImage: "checkmark.circle.fill") // Shortcuts 0_0
                    Label("All New Features, Forever", systemImage: "checkmark.circle.fill") // Guaranteed!
                }
                .font(.body)
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
                        close()
                    }
                }) {
                    Text("Continue")
                        .frame(maxWidth: 300)
                        .font(.body.bold())
                }
                
                .buttonStyle(.borderedProminent)
                .foregroundColor(Color(uiColor: .systemBackground))
                
                Button(action: {
                    Task {
                        try await settingsViewModel.store.restorePurchases()
                        close()
                    }
                }) {
                    Text("Restore Purchases")
                        .frame(maxWidth: 300)
                        .font(.body.bold())
                }
                .buttonStyle(.bordered)
                .foregroundColor(.purple)

            }
            .controlSize(.large)
            .tint(.purple)
            // A little goofy having padding on just the bottom but it looks right
            .padding(.bottom)
            
        }
    }
}


struct ProPreviewSheet_Previews: PreviewProvider {
    @State static var isOpen = true
    
    static var previews: some View {
        ProPreviewSheet(isOpen: $isOpen, feature: "Emojifier")
            .environmentObject(SettingsViewModel())
    }
}
