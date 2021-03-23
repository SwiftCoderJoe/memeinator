//
//  OptionsView.swift
//  m3Keys
//
//  Created by Kids on 3/22/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct OptionsView: View {
    @State var spacingIsOn = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Toggle(isOn: $spacingIsOn, label: {
                        Text("Spacing")
                    })
                    Toggle(isOn: $spacingIsOn, label: {
                        Text("Spacing1")
                    })
                    Toggle(isOn: $spacingIsOn, label: {
                        Text("Spacing2")
                    })
                    Toggle(isOn: $spacingIsOn, label: {
                        Text("Spacing3")
                    })
                    Toggle(isOn: $spacingIsOn, label: {
                        Text("Spacing4")
                    })
                    Toggle(isOn: $spacingIsOn, label: {
                        Text("Spacing5")
                    })
                    Toggle(isOn: $spacingIsOn, label: {
                        Text("Spacing6")
                    })
                }
                
            }.frame(height: 50)
            Spacer()
        }
    }
}

