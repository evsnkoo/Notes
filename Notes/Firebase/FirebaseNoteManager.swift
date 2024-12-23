//
//  FirebaseNoteManager.swift
//  Notes
//
//  Created by Egor Evseenko on 23.12.2024.
//

import Foundation
import FirebaseFirestore

protocol FirebaseNoteManagerProtocol {
    func updateNote(id: String, text: String, date: Date)
    func observeNoteChanges(id: String, completion: @escaping (Note?) -> Void) -> ListenerRegistration
}

class FirebaseNoteManager: FirebaseNoteManagerProtocol {
    private var firebaseDatabase = Firestore.firestore()
    
    func updateNote(id: String, text: String, date: Date) {
        firebaseDatabase
            .collection(FirebaseConstants.notesCollectionName)
            .document(id)
            .updateData(["text": text, "date": date])
    }
    
    func observeNoteChanges(id: String, completion: @escaping (Note?) -> Void) -> ListenerRegistration {
        return firebaseDatabase
            .collection(FirebaseConstants.notesCollectionName)
            .document(id)
            .addSnapshotListener { snapshot, error in
                if error == nil,
                   let snapshot = snapshot,
                   let note = try? snapshot.data(as: Note.self) {
                    completion(note)
                } else {
                    completion(nil)
                }
            }
    }
}
