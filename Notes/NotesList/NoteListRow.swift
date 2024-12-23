//
//  NoteListRow.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import SwiftUI

struct NoteListRow: View {
    let note: Note
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                    Text(note.text.isEmpty
                         ? L10n.noteEmptyTitle
                         : note.text.truncated(length: 20))
                    .lineLimit(1)
                    .font(.headline)
                
                Text(note.date.formatted(date: .long, time: .shortened))
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}
