//
//  VerticalLabel.swift
//  memeinator.new
//
//  Created by Kids on 11/12/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
            configuration.title
            
        }
    }
}
