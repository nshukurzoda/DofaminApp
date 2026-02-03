//
//  ProfileCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 12/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class ProfileCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<ProfileCoordinator>
    
    @Root var start = makeStart
    
    @Route (.push) var myOrders = makeMyOrders
    @Route (.push) var myAddresses = makeMyAddresses
    @Route (.push) var myProfile = makeMyProfile
    
    @ViewBuilder
    func makeStart(viewModel: ProfileViewModel) -> some View {
        ProfileScreen(viewModel: viewModel)
    }
    
    func makeMyOrders(viewModel: MyOrdersViewModel) -> MyOrdersCoordinator {
        MyOrdersCoordinator(viewModel)
    }
    
    func makeMyProfile(viewModel: MyProfileViewModel) -> MyProfileCoordinator {
        MyProfileCoordinator(viewModel)
    }
      
    func makeMyAddresses(viewModel: MyAddressesViewModel)-> MyAddressCoordinator{
        MyAddressCoordinator(viewModel)
    }
    
    init(_ viewModel: ProfileViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
}
