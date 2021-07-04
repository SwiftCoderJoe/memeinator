//
//  OptionsView.swift
//  m3Keys
//
//  Created by Kids on 3/22/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import Combine

/**
 A view which presents meme controls to the user in a horizontal scrolling view 50px tall. A spacer is provided at the bottom to allow for bottom padding.
 */
struct OptionsView: View {
    // Global SettingsViewModel inherited from parent
    @EnvironmentObject var viewModel: SettingsViewModel
    
    @State var spacingOpened: Bool = false
    @State var casingOpened: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    
                    // Spacing
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Button(action: {
                                spacingOpened.toggle()
                            }) {
                                Text("Spacing")
                                    .fixedSize()
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            
                            if spacingOpened {
                                HStack {
                                    Divider()
                                    
                                    // Enabled Toggle
                                    Toggle(isOn: $viewModel.isSpaced, label: {
                                        Text("Enabled:")
                                            .fixedSize()
                                            .font(.subheadline)
                                    })
                                    
                                    Divider()
                                    
                                    // Number of spaces change
                                    Stepper(value: $viewModel.numberOfSpaces,
                                            in: viewModel.spacesRange,
                                            step: viewModel.spacesStep) {
                                        
                                        Text("\(viewModel.numberOfSpaces)")
                                            .fixedSize()
                                            .font(.subheadline)
                                    }
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
                                    .fixedSize()
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                            
                            if casingOpened {
                                HStack {
                                    Divider()
                                    
                                    // Enabled Toggle
                                    Picker(selection: $viewModel.casingSetting, label: Text("")) { // The text view will not get rendered because of the picker style
                                        ForEach(Casing.allCases) {
                                            Text($0.rawValue)
                                                .tag($0)
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                }
                            }
                        }.padding(.horizontal)
                    }
                }.padding(.horizontal)
            }.frame(height: 40)
        }
    }
    
}
