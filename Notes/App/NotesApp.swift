//
//  NotesApp.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import SwiftUI

@main
struct NotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainCoordinator()
        }
    }
}
