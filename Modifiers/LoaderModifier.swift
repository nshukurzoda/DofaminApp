//
//  LoaderModifier.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 06/02/25.
//

import SwiftUI

struct LoaderModifier: ViewModifier {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .tint(themeManager.colors.textNeutral4)
            }
        }
    }
}

extension View {
    func loader(_ isLoading: Binding<Bool>) -> some View {
        self.modifier(LoaderModifier(isLoading: isLoading))
    }
}
