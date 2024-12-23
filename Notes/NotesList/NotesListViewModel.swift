//
//  NotesListViewModel.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import UIKit
import Resolver
import FirebaseFirestore

final class NotesListViewModel: ObservableObject {
    @Published private(set) var notes: [Note] = []
    @Published private(set) var isLoading = true
    
    @Injected private var firebaseNotesManager: FirebaseNotesManagerProtocol
    
    private let coordinator: NotesListCoordinator
    private var firebaseListener: ListenerRegistration?
    
    init(coordinator: NotesListCoordinator) {
        self.coordinator = coordinator
        
        self.setObservers()
    }
    
    deinit {
        firebaseListener?.remove()
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setObservers() {
        observeNotesChanges()
        observeTimeChanges()
    }
    
    private func observeTimeChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTimeChange),
            name: UIApplication.significantTimeChangeNotification,
            object: nil
        )
    }

    private func observeNotesChanges() {
        firebaseListener = firebaseNotesManager.observeNotesChanges { [weak self] notes in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.notes = notes
            }
        }
    }
    
    private func refreshSnapshotListener() {
        firebaseListener?.remove()
        observeNotesChanges()
    }
    
    @objc private func handleTimeChange() {
        refreshSnapshotListener()
    }

    func addNote() {
        var note = Note()
        
        do {
            let document = try firebaseNotesManager.addNote(note: note)
            
            note.id = document.documentID
            navigateToNoteDetail(note: note)
        } catch {
            NSLog("Add note error: \(error)")
        }
    }

    func deleteNote(index: Int) {
        guard let id = notes[index].id else { return }
        
        firebaseNotesManager.deleteNote(id: id)
    }
    
    func navigateToNoteDetail(note: Note) {
        let input = NoteDetailInput(note: note)
        coordinator.navigateToNoteDetail(input: input)
    }
}

