//
//  SettingsView.swift
//  SettingsView
//
//  Created by Kids on 8/24/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            LargeDivider()
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
