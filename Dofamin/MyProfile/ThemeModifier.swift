//
//  ThemeModifier.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 21/03/25.
//

import SwiftUI

enum ColorScheme: String, CaseIterable {
    case dark
    case light
}

class AppThemeViewModel: ObservableObject {
    @AppStorage("theme") var appearance: ColorScheme = ColorScheme.light
}

struct ThemeModeModifier: ViewModifier {
    @ObservedObject var appThemeViewModel: AppThemeViewModel = AppThemeViewModel()

    public func body(content: Content) -> some View {
        content
            .preferredColorScheme(appThemeViewModel.appearance == .dark ? .dark : .light)
    }
}
