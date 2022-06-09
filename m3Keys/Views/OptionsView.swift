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
                
                Text("DEBUG: Pro = \(viewModel.store.pro ? "True" : "False")")
                
                ForEach(viewModel.keyboardButtonOrdering) { function in
                    function.view
                        .environmentObject(viewModel)
                        .environmentObject(toastContext)
                        .environmentObject(actionHandler)
                        .id(function.id)
                }
                
            }.padding(.horizontal)
        }
        .frame(maxHeight: .infinity)
        
    }
    
}
