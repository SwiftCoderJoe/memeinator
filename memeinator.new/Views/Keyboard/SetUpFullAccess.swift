//
//  SetUpFullAccessSheet.swift
//  memeinator.new
//
//  Created by Kids on 1/22/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI
import MarkdownUI

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
            
            VStack {
                Markdown("""
                    1. Tap **Keyboards**
                    2. Enable **Allow Full Access**
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
                Text("Set Up Full Access")
                    .frame(maxWidth: 300)
                    .font(.system(size: 15).bold())
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .foregroundColor(.purple)
            
            Spacer()
        }
    }
}
