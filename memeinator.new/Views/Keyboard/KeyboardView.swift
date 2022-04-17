//
//  KeyboardView.swift
//  KeyboardView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import MarkdownUI

struct KeyboardView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var viewModel: SettingsViewModel
    
    @StateObject var keyboardManager = M3KeysInstallManager()
    
    @State var fullAccessSheetOpen = false
    
    var body: some View {
        VStack(spacing: 0.0) {
            Heading(name: "Keyboard")
            
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
    
    var setUpMemeinatorKeyboard: some View {
        VStack {
            Spacer()

            LargeMessage(iconName: "keyboard.fill", message: "Set up Memeinator Keyboard")
            
            // TODO: We can probably do this without having a Markdown dep
            
            VStack {
                Markdown("""
                    1. Tap **Keyboards**
                    2. Enable **M3Keys**
                    3. Enable **Allow Full Access**
                    """
                )
                    .markdownStyle(
                        MarkdownStyle(
                            font: .system(size: 20)
                        )
                    )
                
                Markdown("*Nothing you type is **ever** saved and cannot be viewed by anyone other than you.*")
            }.padding()
            
            Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                Text("Set Up M3Keys")
                    .frame(maxWidth: 300)
                    .font(.system(size: 15).bold())
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .foregroundColor(.purple)
            
            Spacer()
        }
    }
    
    var keyboardIsWorking: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 40))
                      
            VStack(alignment: .leading) {
                Text("Memeinator Keyboard is installed.")
                    .bold()
                    
                Text("Press and hold the globe icon to use Memeinator Keyboard.")
            }.foregroundColor(Color(uiColor: .systemBackground))
            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .roundedBackground(color: .purple)
        .padding()
    }
    
    var mainUI: some View {
        VStack {
            Spacer()
            
            WideMessage(iconName: "checkmark.circle", message: "Memeinator Keyboard is set up")
            
            NavigationLink(
                destination: KeyboardReorder().environmentObject(viewModel)
            ) {
                HStack {
                    Spacer()
                    Text("Add, Remove, and Reorder Buttons")
                    Image(systemName: "chevron.right")
                    Spacer()
                }
                .font(.system(size: 15).bold())
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}
