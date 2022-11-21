//
//  PasteFunction.swift
//
//  Created by Joe Cardenas on 3/25/22.
//

import Foundation
import SwiftUI
import KeyboardKit
import AlertToast

struct PasteFunction: View {
    @EnvironmentObject var actionHandler: M3KActionHandler
    @EnvironmentObject var toastContext: ToastContext
    
    var body: some View {
        KeyboardButton(title: "Paste", action: {
            guard actionHandler.tryPaste() else {
                return toastContext.present(
                    toast: AlertToast(
                        displayMode: .alert,
                        type: .error(.red),
                        title: "Full Access is required.")
                )
            }
        })
    }
}
