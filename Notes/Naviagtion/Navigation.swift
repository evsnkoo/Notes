//
//  Navigation.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import Foundation
import Combine

final class Navigation<Flow>: ObservableObject where Flow: Hashable {
    @Published var path: [Flow] = []
    
    func next(_ step: Flow) {
        path.append(step)
    }
    
    func popTo(_ step: Flow) {
        guard let first = path.firstIndex(where: { $0 == step }) else { return }
        path = Array(path.prefix(through: first))
    }
    
    func back() {
        path = path.dropLast()
    }
    
    func popToRoot() {
        path = []
    }
    
    deinit { }
}
