//
//  NotesListCoordinator.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import SwiftUI

protocol NotesListRoutable {
    func navigateToNoteDetail(input: NoteDetailInput)
}

struct NotesListCoordinator {
    let navigationPath: Navigation<MainFlow>
    
    func view() -> some View {
        NotesListView(viewModel: NotesListViewModel(coordinator: self))
    }
}

extension NotesListCoordinator: NotesListRoutable {
    func navigateToNoteDetail(input: NoteDetailInput) {
        navigationPath.next(.noteDetail(input))
    }
}
