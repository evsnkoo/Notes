//
//  Resolver+Services.swift
//  Notes
//
//  Created by Egor Evseenko on 23.12.2024.
//

import Foundation

import Resolver
import Foundation

extension Resolver {
    public static func registerServices() {
        register { FirebaseNotesManager() }
            .implements(FirebaseNotesManagerProtocol.self)
        register { FirebaseNoteManager() }
            .implements(FirebaseNoteManagerProtocol.self)
    }
}
