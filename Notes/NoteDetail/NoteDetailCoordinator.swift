//
//  NoteDetailCoordinator.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import SwiftUI

protocol NoteDetailRoutable {
    func navigateBack()
}

struct NoteDetailCoordinator {
    let navigationPath: Navigation<MainFlow>
    let input: NoteDetailInput
    
    func view() -> some View {
        NoteDetailView(viewModel: NoteDetailViewModel(input: input, coordinator: self))
    }
}

extension NoteDetailCoordinator: NoteDetailRoutable {
    func navigateBack() {
        navigationPath.back()
    }
}
