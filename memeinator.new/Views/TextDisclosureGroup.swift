//
//  TextDisclosureGroup.swift
//  TextDisclosureGroup
//
//  Created by Kids on 9/2/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct TextDisclosureGroup<Content>: View where Content: View {
    @State private var isExpandedState = false
    var isExpanded: Binding<Bool>?
    let label: String
    let content: Content
    
    init(_ label: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.isExpanded = isExpanded
        self.label = label
        self.content = content()
    }
    
    init(_ label: String, @ViewBuilder content: () -> Content) {
        self.isExpanded = nil
        self.content = content()
        self.label = label
    }
    
    
    // Return the wrapper
    var body: some View {
        _TextDisclosureGroup(isExpanded: isExpanded ?? $isExpandedState, label: label) {
            content
        }
    }
    
    // MARK: Wrapper
    private struct _TextDisclosureGroup<Content>: View where Content: View {
        @Binding var isExpanded: Bool
        let label: String
        let content: Content
        
        init(isExpanded: Binding<Bool>, label: String, @ViewBuilder content: () -> Content) {
            self._isExpanded = isExpanded
            self.label = label
            self.content = content()
        }
        
        // Actual implementation
        var body: some View {
            Section(header:
                Button(action: {
                    print(label)
                    print("Big if true")
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(label)
                            .font(.system(size: 25))
                            .autocapitalization(.words)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right.circle")
                            .imageScale(.large)
                            .rotationEffect(.degrees(isExpanded ? 90 : 0))
                            .scaleEffect(isExpanded ? 1.5 : 1, anchor: .center)
                    }
            }) {
                
                if isExpanded {
                    content
                }
                
            }
        }
    }
}



struct TextDisclosureGroup_Previews: PreviewProvider {

    @State static var isExpanded = false
    @State static var dummyToggle = false

    static var previews: some View {
        Form {
            TextDisclosureGroup("Casing", isExpanded: $isExpanded) {
                Toggle("Enabled", isOn: $dummyToggle)
            }
        }
    }
}
