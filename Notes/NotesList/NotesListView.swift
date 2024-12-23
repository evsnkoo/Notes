//
//  NotesListView.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import SwiftUI

struct NotesListView: View {
    @StateObject var viewModel: NotesListViewModel

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                progressView
            } else {
                notesList
            }
        }
        .navigationTitle(L10n.notesListNavigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                addNoteButton
            }
        }
    }
    
    private var notesList: some View {
        List {
            ForEach(viewModel.notes, id: \.id) { note in
                NoteListRow(
                    note: note,
                    onTap: {
                        viewModel.navigateToNoteDetail(note: note)
                    }
                )
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    viewModel.deleteNote(index: index)
                }
            }
        }
    }
    
    private var progressView: some View {
        ZStack(alignment: .center) {
            ProgressView()
                .tint(.blue)
        }
    }
    
    private var addNoteButton: some View {
        Button {
            viewModel.addNote()
        } label: {
            Image(systemName: "plus")
        }
    }
}
