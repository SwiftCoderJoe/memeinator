//
//  ToastContext.swift
//  m3Keys
//
//  Created by L David Cardenas on 11/21/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import AlertToast

/// A ridiculously overengineered toast context with a queue
class ToastContext: ObservableObject {
    
    /// Shows whether the toast in this context is currently showing. This should not be set directly, and is instead set to true when `present(toast:)` is called.
    @Published var showToast = false
    
    @Published var readyForToast = true
    
    /// The toast that is currently being shown. This should not be set directly, and is instead set to the value passed into `present(toast:)`
    ///
    /// The initial value is never shown.
    @Published var toastAlert = AlertToast(type: .regular, title: "Not shown.")
    
    var toastAlertQueue: [AlertToast] = []
    
    
    func present(toast: AlertToast) {
        if readyForToast {
            toastAlert = toast
            showToast = true
            readyForToast = false
        } else {
            toastAlertQueue.append(toast)
        }
    }
    
    func presentNextToastInQueue() {
        if toastAlertQueue.count == 0 {
            readyForToast = true
            return
        } else {
            toastAlert = toastAlertQueue.popLast()!
        }
        showToast = true
    }
}
