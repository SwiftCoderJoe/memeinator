//
//  SetUpFullAccessSheet.swift
//
//  Created by Joe Cardenas on 1/22/22.
//

import Foundation
import SwiftUI

/// A small view that can be presented in order to guide the user through setting up Full Access for Memeinator Keyboard.
struct SetUpFullAccess: View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Full Access")
                
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
            
            Spacer()
            
            LargeMessage(iconName: "keyboard.fill", message: "Set up Full Access")
            
            VStack(spacing: 10) {
                Text("""
                    1. Tap **Set Up Full Access**
                    2. Tap **Keyboards**
                    3. Enable **Allow Full Access**
                    """
                )
                
                Text("*Nothing you type is **ever** saved and cannot be viewed by anyone other than you.*")
            }.padding()
            
            Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                Text("Set Up Full Access")
                    .frame(maxWidth: 300)
                    .font(.body.bold())
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .foregroundColor(.purple)
            
            Spacer()
        }
    }
}

struct SetUpFullAccess_Previews: PreviewProvider {
    
    @State static var isOpen = true

    
    static var previews: some View {
        SetUpFullAccess(isOpen: $isOpen)
    }
}
