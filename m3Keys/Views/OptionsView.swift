//
//  OptionsView.swift
//
//  Created by Joe Cardenas on 3/22/21.
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
    @EnvironmentObject var toastContext: ToastContext
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                
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
