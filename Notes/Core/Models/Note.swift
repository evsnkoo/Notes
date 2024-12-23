//
//  Note.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import FirebaseFirestore

struct Note: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var text: String
    var date: Date

    init(
        id: String? = nil,
        text: String = "",
        date: Date = Date()
    ) {
        self.id = id
        self.text = text
        self.date = date
    }
}
