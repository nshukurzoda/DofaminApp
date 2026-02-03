//
//  SplashScreen.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 03/02/25.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        VStack {
            ProgressView()
                .tint(themeManager.colors.textNeutral4)
        }
        .alert(
            viewModel.error.message,
            isPresented: $viewModel.error.isPresented
        ) {
            Button("OK") {
                AuthenticationService.shared.status = .unauthenticated
            }
        }
        .onAppear(perform: {
            viewModel.checkAuth()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeManager.colors.bgNeutral2)
    }
}

#Preview {
    SplashScreen(viewModel: .init())
        .environmentObject(ThemeManager(theme: .light))
}
