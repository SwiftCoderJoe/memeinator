//
//  KeyboardFunctionSettings.swift
//  memeinator.new
//
//  Created by Kids on 2/5/22.
//  Copyright © 2022 BytleBit. All rights reserved.
//

import Foundation
import SwiftUI

struct KeyboardReorder: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        // when cross-section .onMove works, we should change this so that we can drag between lists instead of using + and - buttons.
        VStack {
            List {
                Section(header:
                    Text("Memeinator Keyboard functions are displayed from left to right.")
                            .lineLimit(nil)
                ) {
                    ForEach(viewModel.keyboardButtonOrdering) { function in
                        Text(function.rawValue)
                            .id(function.rawValue)
                            .foregroundColor(.white)
                            .padding(10)
                            .roundedBackground(color: .purple)
                    }
                    .onMove { source, destination in
                        viewModel.keyboardButtonOrdering.move(fromOffsets: source, toOffset: destination)
                    }
                    .onDelete { indices in
                        for index in indices {
                            viewModel.unusedKeyboardButtons.append(viewModel.keyboardButtonOrdering[Int(index)])
                            viewModel.keyboardButtonOrdering.remove(at: index)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                
                Section(header:
                    Text("More Functions")
                ) {
                    if viewModel.unusedKeyboardButtons.count == 0 {
                        Text("You've already added all the functions available! Stay tuned for more functions coming soon.")
                    } else {
                        // This array copy is a little heavy, but it seems to be the only way I can get both element and function.
                        ForEach(Array(viewModel.unusedKeyboardButtons.enumerated()), id: \.element) { index, function in
                            
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 21))
                                    .foregroundColor(.green)
                                
                                Text(function.rawValue)
                                    .id(function.rawValue)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .roundedBackground(color: .purple)
                            }
                            .onTapGesture {
                                withAnimation {
                                    viewModel.keyboardButtonOrdering.append(viewModel.unusedKeyboardButtons[index])
                                    viewModel.unusedKeyboardButtons.remove(at: index)
                                }
                            }
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .environment(\.editMode, .constant(.active))
        }
        .navigationTitle("Reorder")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct KeyboardReorder_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardReorder()
            .environmentObject(SettingsViewModel())
    }
}
