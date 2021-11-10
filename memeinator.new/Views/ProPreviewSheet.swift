//
//  ProPreviewSheet.swift
//  memeinator.new
//
//  Created by Kids on 11/10/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct ProPreviewSheet: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Memeinator")
                    .font(.largeTitle)
                Text("Pro")
                    .font(.largeTitle)
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .padding(5)
                    .background(.purple, in: RoundedRectangle(cornerRadius: 10))
                
                Spacer()
            }.padding()
            LargeDivider()
            
            Spacer()
        }
    }
}
