//
//  NoteDetailView.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import SwiftUI

struct NoteDetailView: View {
    @StateObject var viewModel: NoteDetailViewModel
    @FocusState private var isTextEditorFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $viewModel.text)
                .focused($isTextEditorFocused)
                .font(.body)
                .padding(10)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(L10n.noteDetailNavigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                doneButton
            }
        }
    }
    
    @ViewBuilder
    private var doneButton: some View {
        if isTextEditorFocused {
            Button {
                isTextEditorFocused = false
            } label: {
                Text(L10n.coreButtonDone)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
}

