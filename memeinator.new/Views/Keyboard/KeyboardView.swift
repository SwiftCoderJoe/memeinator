//
//  KeyboardView.swift
//
//  Created by Joe Cardenas on 8/24/21.
//

import SwiftUI

/// The Keyboard tab of the Memeinator App
struct KeyboardView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var viewModel: SettingsViewModel
    
    @StateObject var keyboardManager = M3KeysInstallManager()
    
    @State var fullAccessSheetOpen = false
    @State var proPreviewSheetOpen = false
    
    var body: some View {
        VStack(spacing: 0.0) {
            Heading("Keyboard")
            
            // If the user does not have the keyboard installed, show them how to install it.
            if !keyboardManager.installed {
                setUpMemeinatorKeyboard
            } else {
                ZStack(alignment: .top) {
                    
                    mainUI
                    
                    // Warnings
                    VStack {
                        // If the user does not have full access enabled, show them a warning.
                        if !keyboardManager.fullAccess {
                            fullAccessWarning
                        }
                    }
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                keyboardManager.updateKeyboardState()
                print("Updating keyboard install state")
            }
        }
    }
    
    /// A small warning badge that allows the user to set up full access.
    var fullAccessWarning: some View {
        Button(action: {
            fullAccessSheetOpen = true
        }) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 40))
                          
                VStack(alignment: .leading) {
                    Text("Full Access is not enabled.")
                        .bold()
                    Text("Tap to set up Full Access.")
                }
                .foregroundColor(.primary)
                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
            .padding()
        }
        .sheet(isPresented: $fullAccessSheetOpen) {
            SetUpFullAccess(isOpen: $fullAccessSheetOpen)
        }
        
    }
    
    /// A full screen view that allows the user to begin initial setup for memeinator keyboard.
    var setUpMemeinatorKeyboard: some View {
        VStack {
            Spacer()

            LargeMessage(iconName: "keyboard.fill", message: "Set up Memeinator Keyboard")
                        
            VStack(spacing: 10) {
                Text("""
                    1. Tap **Set Up Memeinator Keyboard**
                    2. Tap **Keyboards**
                    3. Enable **Memeinator**
                    4. Enable **Allow Full Access**
                    """
                )
                
                Text("*Nothing you type is **ever** saved and cannot be viewed by anyone other than you.*")
            }.padding()
            
            Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                Text("Set Up Memeinator Keyboard")
                    .frame(maxWidth: 300)
                    .font(.body.bold())
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .foregroundColor(.purple)
            
            Spacer()
        }
    }
    
    /// A full screen view that allows you to control memeinator keyboard.
    var mainUI: some View {
        VStack {
            Spacer()
            
            WideMessage(iconName: "checkmark.circle", message: "Memeinator Keyboard is set up")

            VStack(spacing: 0) {
                ProBadge(pro: viewModel.store.pro, action: {
                    proPreviewSheetOpen.toggle()
                }, backgroundColor: Color(uiColor: .systemBackground), foregroundColor: .purple)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ProLink(pro: viewModel.store.pro,
                    getProAction: { proPreviewSheetOpen.toggle() },
                    destination: KeyboardReorder().environmentObject(viewModel),
                    name: "Add, Remove, and Reorder Buttons")
            }
            
            Spacer()
        }
        .sheet(isPresented: $proPreviewSheetOpen) {
            ProPreviewSheet(isOpen: $proPreviewSheetOpen, feature: "Customization")
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .previewDisplayName("Set Up Keyboard")
        KeyboardView().fullAccessWarning
            .previewDisplayName("Full Access Warning")
    }
}
