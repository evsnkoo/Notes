//
//  String+Extension.swift
//  Notes
//
//  Created by Egor Evseenko on 21.12.2024.
//

import Foundation

extension String {
    func truncated(length: Int, trailing: String = "...") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}
