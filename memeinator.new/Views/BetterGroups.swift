//
//  TextDisclosureGroup.swift
//  TextDisclosureGroup
//
//  Created by Kids on 9/2/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import SwiftUI
import m3Keys

// MARK: Disclosure groups

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
    
    // Wrapper
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
                        
                        if isExpanded {
                            Text("Enabled")
                                .foregroundColor(Color(uiColor: .systemGroupedBackground))
                                .padding(5)
                                .background(.purple, in: RoundedRectangle(cornerRadius: 5))
                        } else {
                            Text("Disabled")
                                .padding(5)
                        }
                        
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
    // ProFeature needs settingsViewModel so it can access the store
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @State var proOpen = false
    var isExpanded: Binding<Bool>?
    let label: String
    let content: Content
    
    init(_ label: String, isExpanded: Binding<Bool>? = nil, @ViewBuilder content: () -> Content) {
        self.isExpanded = isExpanded
        self.label = label
        self.content = content()
    }
    
    init(_ label: String, isExpanded: Binding<Bool>? = nil) where Content == EmptyView {
        self.init(label, isExpanded: isExpanded) { }
    }
    
    var body: some View {
        Feature(header: {
            Group {
                ProBadge(pro: settingsViewModel.store.pro, action: {
                    proOpen.toggle()
                })
            }
            .sheet(isPresented: $proOpen, content: {
                ProPreviewSheet(isOpen: $proOpen, feature: label)
                    .textCase(.none)
                    .environmentObject(settingsViewModel)
            })
            
            Text(label)
                .font(.system(size: 15))
            
        }, isExpanded: isExpanded) {
            content
        }
    }
}

// MARK: Form Groups

/**
 A group used in the settings portion of memeinator. Needs SettingsViewModel environment object.
 */
struct ProGroup<Content>: View where Content: View {
    
    @EnvironmentObject var viewModel: SettingsViewModel
    
    let name: String
    let content: Content
    let feature: String
    
    @State var proPreviewOpen = false
    
    init(name: String, feature: String = "Settings", @ViewBuilder content: () -> Content) {
        self.name = name
        self.feature = feature
        self.content = content()
    }
    
    var body: some View {
        Section(header: HStack {
            ProBadge(pro: viewModel.store.pro, action: { /* Not needed */ })
            Text(name)
        }) {
            content
        }
        .disabled(!viewModel.store.pro)
        // We can't use .onTapGesture here because it interferes with SwiftUI!! Rah Apple bad or something!
        .gesture( viewModel.store.pro ? nil :
            (TapGesture()
                .onEnded {
                    if !viewModel.store.pro {
                        proPreviewOpen.toggle()
                    }
            })
                              
        )
        .sheet(isPresented: $proPreviewOpen) {
            ProPreviewSheet(isOpen: $proPreviewOpen, feature: "Settings")
        }
    }
}
