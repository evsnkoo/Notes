//
//  MainCoordinator.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import SwiftUI

struct MainCoordinator: View {
    @StateObject private var navigationPath = Navigation<MainFlow>()
    
    var body: some View {
        NavigationStack(path: $navigationPath.path) {
            NotesListCoordinator(navigationPath: navigationPath)
                .view()
                .navigationDestination(for: MainFlow.self) { flow in
                    switch flow {
                    case let .noteDetail(input):
                        NoteDetailCoordinator(navigationPath: navigationPath, input: input).view()
                    }
                }
        }
    }
}

enum MainFlow: Hashable {
    case noteDetail(_ input: NoteDetailInput)
}
