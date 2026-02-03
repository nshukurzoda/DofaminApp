//
//  Extension+Array.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 14/12/24.
//

import Foundation

extension Array where Element: Equatable {
    func isLast(_ element: Element) -> Bool {
        self.last == element
    }
}
