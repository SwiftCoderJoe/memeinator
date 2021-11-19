//
//  OptionsView.swift
//  m3Keys
//
//  Created by Kids on 3/22/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import KeyboardKit

/**
 A view which presents meme controls to the user in a horizontal scrolling view 45px tall.
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
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                
                // Paste
                HStack {
                    VStack {
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
                    
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
                .roundedBackground(color: .gray)
                                    
                // Spacing
                HStack {
                    Button(action: {
                        viewModel.isSpaced.toggle()
                    }) {
                        Text("Spacing")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    if viewModel.isSpaced {
                        
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
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
                .roundedBackground(color: viewModel.isSpaced ? .purple : .gray)
                
                
                // Casing
                HStack {
                    Button(action: {
                        viewModel.casingOn.toggle()
                    }) {
                        Text("Casing")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    if viewModel.casingOn {
                        HStack {
                            Divider()
                            
                            // Casing picker
                            Picker("Casing Type", selection: $viewModel.enabledCasingSetting) {
                                ForEach(Casing.allCases[1...]) {
                                    Text($0.rawValue)
                                        .tag($0)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
                .roundedBackground(color: viewModel.casingOn ? .purple : .gray)
                
                // Furryspeak
                HStack {
                    Button(action: {
                        viewModel.furryspeakEnabled.toggle()
                    }) {
                        Text("Furryspeak")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    if viewModel.furryspeakEnabled {
                        Divider()
                        
                        Text("Stutter:")
                            .font(.subheadline)
                        
                        // Enabled Toggle
                        Toggle("Stutter Enabled", isOn: $viewModel.stutterEnabled)
                            .labelsHidden()
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal)
                .roundedBackground(color: viewModel.furryspeakEnabled ? .purple : .gray)
                
            }.padding(.horizontal)
        }
        .frame(maxHeight: .infinity)
        
    }
    
}
