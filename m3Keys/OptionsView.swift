//
//  OptionsView.swift
//  m3Keys
//
//  Created by Kids on 3/22/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import Combine

struct OptionsView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing")
                    })
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing1")
                    })
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing2")
                    })
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing3")
                    })
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing4")
                    })
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing5")
                    })
                    Toggle(isOn: $viewModel.isSpaced, label: {
                        Text("Spacing6")
                    })
                }
                
            }.frame(height: 50)
            Spacer()
        }
    }
}

