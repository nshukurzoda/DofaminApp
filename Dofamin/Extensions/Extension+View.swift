//
//  Extension+View.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/12/24.
//

import Foundation
import SwiftUI

extension View {
    func frame(square: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: square, height: square, alignment: alignment)
    }
}

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
