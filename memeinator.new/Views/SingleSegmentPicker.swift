//
//  SingleSegmentPicker.swift
//  SingleSegmentPicker
//
//  Created by Kids on 9/1/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI
import ViewExtractor


/**
 Experimental SwiftUI crap
 
 Basically the idea of this is a Picker that just cycles through options by clicking once. It's not really easily possible in the current state of SwiftUI, requiring the packages `GeorgeElsham/ViewExtractor` and `GeorgeElsham/TagExtractor`, so for now I've just given up. I'm leaving the code here in case I ever want to pick it up again, though.
 */



/*
struct SingleSegmentPicker<Content>: View where Content: View {
    let views: [AnyView]
    
    init(@ViewBuilder content: () -> Content) {
        // Requires `GeorgeElsham/ViewExtractor`
        // self.views = ViewExtractor.getViews(from: content)
    }
    
    var body: some View {
        Group {
            
        }
    }
}

struct SingleSegmentPicker_Previews: PreviewProvider {
    static var previews: some View {
        SingleSegmentPicker(content: {
            ForEach(Casing.allCases) {
                Text($0.rawValue)
                    .tag($0)
            }
        })
    }
}
*/
