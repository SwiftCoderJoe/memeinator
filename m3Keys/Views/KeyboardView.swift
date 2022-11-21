//
//  KeyboardView.swift
//
//  Created by Joe Cardenas on 2020-06-10.
//

import SwiftUI
import KeyboardKit
import AlertToast

/**
 This view is the main view that is used by the extension by
 calling `setup(with:)` in `KeyboardViewController`.
 
 The view will switch over the current keyboard type and add
 the correct keyboard view.
 */
struct KeyboardView: View {
    
    // Custom M3KActionHandler
    var actionHandler: KeyboardActionHandler
    
    // Global SettingsViewModel inherited from KeyboardViewController.swift
    @EnvironmentObject var viewModel: SettingsViewModel
    
    // Standard keyboardContext and toastContext
    @EnvironmentObject var keyboardContext: KeyboardContext
    @EnvironmentObject var toastContext: ToastContext
    
    
    var body: some View {
        VStack(spacing: 0) {
            if keyboardContext.keyboardType != .emojis {
                optionsView.padding(.top, 5)
            }
            SystemKeyboard()
        }
        .toast(isPresenting: $toastContext.showToast, tapToDismiss: true) {
            toastContext.toastAlert
        } completion: {
            toastContext.presentNextToastInQueue()
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    // optionsView from OptionsView.swift -- shows meme options, actions, and settings
    var optionsView: some View {
        OptionsView(
            actionHandler: actionHandler as! M3KActionHandler)
        .environmentObject(viewModel)
        .environmentObject(toastContext)
        .frame(height: 45)
    }
    
}
