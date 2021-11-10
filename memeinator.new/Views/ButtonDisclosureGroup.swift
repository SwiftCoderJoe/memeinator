//
//  TextDisclosureGroup.swift
//  TextDisclosureGroup
//
//  Created by Kids on 9/2/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI

struct Feature<Content, Header>: View where Content: View, Header: View {
    @State private var isExpandedState = false
    var isExpanded: Binding<Bool>?
    let content: Content
    let header: Header
    
    init(_ label: String, isExpanded: Binding<Bool>? = nil, @ViewBuilder content: () -> Content) where Header == Text {
        self.init(header: {
            Text(label)
                .font(.system(size: 15))
        }, isExpanded: isExpanded, content: content)
    }
    
    init(@ViewBuilder header: () -> Header, isExpanded: Binding<Bool>? = nil, @ViewBuilder content: () -> Content) {
        self.isExpanded = isExpanded
        self.header = header()
        self.content = content()
    }
    
    
    
    // Return the wrapper
    var body: some View {
        _TextDisclosureGroup(header: {
            header
        }, isExpanded: isExpanded ?? $isExpandedState) {
            content
        }
    }
    
    // MARK: Wrapper
    private struct _TextDisclosureGroup<Content, Header>: View where Content: View, Header: View {
        @Binding var isExpanded: Bool
        let header: Header
        let content: Content
        
        init(@ViewBuilder header: () -> Header, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
            self._isExpanded = isExpanded
            self.header = header()
            self.content = content()
        }
        
        // Actual implementation
        var body: some View {
            Section(header:
                Button(action: {
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        header
                        
                        Spacer()
                        
                        Text(isExpanded ? "Enabled" : "Disabled")
                    }
            }) {
                
                if isExpanded {
                    content
                }
                
            }
        }
    }
}

struct ProFeature<Content>: View where Content: View {
    @State var proOpen = false
    var isExpanded: Binding<Bool>?
    let label: String
    let content: Content
    
    init(_ label: String, isExpanded: Binding<Bool>? = nil, @ViewBuilder content: () -> Content) {
        self.isExpanded = isExpanded
        self.label = label
        self.content = content()
    }
    
    var body: some View {
        Feature(header: {
            Button(action: {
                proOpen.toggle()
            }) {
                Label("Pro", systemImage: "lock")
                    .foregroundColor(Color(uiColor: .systemGroupedBackground))
                    .padding(5)
                    .background(.purple, in: RoundedRectangle(cornerRadius: 5))
            }
            .sheet(isPresented: $proOpen, content: {
                ProPreviewSheet()
                    .foregroundColor(.purple)
            })
            
            Text(label)
                .font(.system(size: 15))
        }, isExpanded: isExpanded) {
            content
        }
    }
}

struct TextDisclosureGroup_Previews: PreviewProvider {

    @State static var isExpanded = false
    @State static var dummyToggle = false

    static var previews: some View {
        Form {
            Feature("Casing", isExpanded: $isExpanded) {
                Toggle("Enabled", isOn: $dummyToggle)
            }
        }
    }
}
