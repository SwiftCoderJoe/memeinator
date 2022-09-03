//
//  PasteFunction.swift
//
//  Created by Joe Cardenas on 3/25/22.
//

import Foundation
import SwiftUI
import KeyboardKit

struct PasteFunction: View {
    @EnvironmentObject var actionHandler: M3KActionHandler
    @EnvironmentObject var toastContext: KeyboardToastContext
    
    var body: some View {
        KeyboardButton(title: "Paste", action: {
            guard actionHandler.tryPaste() else {
                return toastContext.present(Text("Full Access is required.")
                                        .font(.headline)
                                        .foregroundColor(.gray))
            }
        })
    }
}
