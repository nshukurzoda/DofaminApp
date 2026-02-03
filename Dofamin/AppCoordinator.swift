//
//  AppCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/01/25.
//

import Foundation
import Stinsen
import SwiftUI
import Combine

final class AppCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<AppCoordinator> = .init(initial: \.splash, SplashViewModel())
    
    @Root var authenticated = makeAuthenticated
    @Root var unauthenticated = makeUnauthenticated
    @Root var splash = makeSplash
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func makeAuthenticated() -> AuthenticatedCoordinator {
        AuthenticatedCoordinator(catalogViewModel: CatalogViewModel(), cartViewModel: CartViewModel(), profileViewModel: ProfileViewModel())
    }
    
    func makeUnauthenticated(viewModel: RegistrationViewModel) -> NavigationViewCoordinator<RegistrationCoordinator> {
        NavigationViewCoordinator(RegistrationCoordinator(viewModel))
    }
    
    func makeSplash(viewModel: SplashViewModel) -> some View {
        SplashScreen(viewModel: viewModel)
    }
    
    @ViewBuilder func customize(_ view: AnyView) -> some View {
        view
            .onReceive(AuthenticationService.shared.$status) { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .authenticated, .onboarding:
                    root(\.authenticated)
                case .unauthenticated:
                    root(\.unauthenticated, RegistrationViewModel())
                case .idle:
                    root(\.splash, SplashViewModel())
                }
            }
            .modifier(ThemeModeModifier())
            .environmentObject(ThemeManager())

        
    }
}
