//
//  AuthenticatedCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 11/01/25.
//
import Foundation
import Stinsen
import SwiftUI

final class AuthenticatedCoordinator: TabCoordinatable {
    @EnvironmentObject var themeManager: ThemeManager
    
    var child: Stinsen.TabChild = TabChild(
        startingItems: KeychainManager.shared.isIdentified
        ? [
            \AuthenticatedCoordinator.catalog,
             \AuthenticatedCoordinator.cart,
             \AuthenticatedCoordinator.profile
        ]
        : [
            \AuthenticatedCoordinator.catalog,
             \AuthenticatedCoordinator.profile
        ]
        
    )
    
    var isActive: Bool = true
    
    @Route(tabItem: makeCatalogTab) var catalog = makeCatalog
    @Route(tabItem: makeCartTab) var cart = makeCart
    @Route(tabItem: makeProfileTab) var profile = makeProfile
    
    
    let catalogViewModel: CatalogViewModel
    let cartViewModel: CartViewModel
    let profileViewModel: ProfileViewModel
    
    
    init(catalogViewModel: CatalogViewModel, cartViewModel: CartViewModel, profileViewModel: ProfileViewModel) {
        self.catalogViewModel = catalogViewModel
        self.cartViewModel = cartViewModel
        self.profileViewModel = profileViewModel
    }
    
    
    @ViewBuilder func makeCatalogTab(isActive: Bool) ->  some View {
        Image(systemName: "square.grid.2x2" + (isActive ? ".fill" : ""))
        Text("Каталог")
    }
    
    @ViewBuilder func makeCartTab(isActive: Bool) ->  some View {
        Image(systemName: "cart" + (isActive ? ".fill" : ""))
        Text("Корзина")
    }
    
    @ViewBuilder func makeProfileTab(isActive: Bool) -> some View {
        Image(systemName: "person.circle" + (isActive ? ".fill" : ""))
        Text("Профиль")
    }
    
    func makeCatalog()  -> NavigationViewCoordinator<CatalogCoordinator> {
        return NavigationViewCoordinator(CatalogCoordinator(CatalogViewModel()))
    }
    
    func makeProfile() -> NavigationViewCoordinator<ProfileCoordinator> {
        return NavigationViewCoordinator(ProfileCoordinator(ProfileViewModel()))
    }
    
    func makeCart() -> NavigationViewCoordinator<CartCoordinator> {
        return NavigationViewCoordinator(CartCoordinator(CartViewModel()))
    }
}
