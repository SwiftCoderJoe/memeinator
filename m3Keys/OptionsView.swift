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
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    
                    // Spacing toggle
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing")
                            .font(.headline)
                    })
                    
                }
                .padding(.horizontal)
            }.frame(height: 50)
            Spacer()
        }
    }
    
}
