//
//  DofaminApp.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/12/24.
//

import SwiftUI

@main
struct DofaminApp: App {
    @ObservedObject var stringsManager: StringsManager = StringsManager(language: .ru)
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator()
                .view()
                .accentColor(Palette.brand6)
                .environmentObject(stringsManager)
        }
    }
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
}
