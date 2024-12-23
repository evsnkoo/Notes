//
//  NoteDetailViewModel.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import UIKit
import Combine
import Resolver
import FirebaseFirestore

final class NoteDetailViewModel: ObservableObject {
    @Published var text: String
    
    @Injected private var firebaseNoteManager: FirebaseNoteManagerProtocol
    
    private let noteID: String?
    private let coordinator: NoteDetailCoordinator
    private var firebaseDatabase = Firestore.firestore()
    private var firebaseListener: ListenerRegistration?
    private var subscriptions = Set<AnyCancellable>()
    
    init(input: NoteDetailInput, coordinator: NoteDetailCoordinator) {
        self.noteID = input.note.id
        self.text = input.note.text
        self.coordinator = coordinator
        
        self.setObservers()
    }
    
    deinit {
        firebaseListener?.remove()
    }
    
    private func setObservers() {
        observeNoteChanges()
        observeTextChanges()
    }
    
    private func observeTextChanges() {
        $text
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.updateNote(text)
            }
            .store(in: &subscriptions)
    }
    
    private func observeNoteChanges() {
        guard let noteID else { return }

        firebaseListener = firebaseNoteManager.observeNoteChanges(id: noteID) { [weak self] note in
            guard let self,
                  let note else {
                return
            }
            
            DispatchQueue.main.async {
                self.text = note.text
            }
        }
    }
    
    func updateNote(_ text: String) {
        guard let noteID else { return }
        
        firebaseNoteManager.updateNote(id: noteID, text: text, date: Date())
    }
}
