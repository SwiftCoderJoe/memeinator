//
//  ProBadge.swift
//  memeinator.new
//
//  Created by Kids on 12/15/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct ProBadge: View {
    
    let pro: Bool
    
    let action: () -> Void
    
    var body: some View {
        if pro {
            Label("Pro", systemImage: "lock")
                .labelStyle(.titleOnly)
                .foregroundColor(Color(uiColor: .systemGroupedBackground))
                .padding(5)
                .background(.purple, in: RoundedRectangle(cornerRadius: 5))
        } else {
            Button(action: action) {
                Label("Pro", systemImage: "lock")
                    .foregroundColor(Color(uiColor: .systemGroupedBackground))
                    .padding(5)
                    .background(.purple, in: RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}
