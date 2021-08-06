//
//  OptionsView.swift
//  m3Keys
//
//  Created by Kids on 3/22/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import Combine
import KeyboardKit

/**
 A view which presents meme controls to the user in a horizontal scrolling view 50px tall. A spacer is provided at the bottom to allow for bottom padding.
 */
struct OptionsView: View {
    public init(
        actionHandler: M3KActionHandler) {
        self.actionHandler = actionHandler
    }
    
    private let actionHandler: M3KActionHandler
    
    // Global SettingsViewModel inherited from parent
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var toastContext: KeyboardToastContext
    
    @State var spacingOpened: Bool = false
    @State var casingOpened: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    
                    // Paste
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Button(action: {
                                guard actionHandler.tryPaste() else {
                                    return toastContext.present(Text("Full Access is required.")
                                                            .font(.headline)
                                                            .foregroundColor(.gray))
                                }
                            }) {
                                Text("Paste")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    
                    // Spacing
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Button(action: {
                                spacingOpened.toggle()
                            }) {
                                Text("Spacing")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            
                            if spacingOpened {
                                Divider()
                                
                                Text("Enabled:")
                                    .font(.subheadline)
                                
                                // Enabled Toggle
                                Toggle("Spacing Enabled", isOn: $viewModel.isSpaced)
                                    .labelsHidden()
                                
                                Divider()
                                
                                // Number of spaces change
                                Stepper(value: $viewModel.numberOfSpaces,
                                        in: viewModel.spacesRange,
                                        step: viewModel.spacesStep) {
                                    
                                    Text("\(viewModel.numberOfSpaces)")
                                        .font(.subheadline)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    
                    // Casing
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Button(action: {
                                casingOpened.toggle()
                            }) {
                                Text("Casing")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            
                            if casingOpened {
                                HStack {
                                    Divider()
                                    
                                    // Enabled Toggle
                                    Picker("Casing Type", selection: $viewModel.casingSetting) { 
                                        ForEach(Casing.allCases) {
                                            Text($0.rawValue)
                                                .tag($0)
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }.padding(.horizontal)
            }.frame(height: 40)
        }
        
    }
    
}
