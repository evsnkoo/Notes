//
//  FirebaseNotesManager.swift
//  Notes
//
//  Created by Egor Evseenko on 23.12.2024.
//

import Foundation
import FirebaseFirestore

protocol FirebaseNotesManagerProtocol {
    func addNote(note: Note) throws -> DocumentReference
    func deleteNote(id: String)
    func observeNotesChanges(completion: @escaping ([Note]) -> Void) -> ListenerRegistration
}

class FirebaseNotesManager: FirebaseNotesManagerProtocol {
    private var firebaseDatabase = Firestore.firestore()
    
    func addNote(note: Note) throws -> DocumentReference {
         let reference = try firebaseDatabase
             .collection(FirebaseConstants.notesCollectionName)
             .addDocument(from: note)
         
         return reference
     }
    
    func deleteNote(id: String) {
        firebaseDatabase
            .collection(FirebaseConstants.notesCollectionName)
            .document(id)
            .delete()
    }
    
    func observeNotesChanges(completion: @escaping ([Note]) -> Void) -> ListenerRegistration {
        return firebaseDatabase
            .collection(FirebaseConstants.notesCollectionName)
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                if error == nil,
                   let snapshot {
                    let notes = snapshot.documents.compactMap { document in
                        try? document.data(as: Note.self)
                    }
                    
                    completion(notes)
                } else {
                    completion([])
                }
            }
    }
}
