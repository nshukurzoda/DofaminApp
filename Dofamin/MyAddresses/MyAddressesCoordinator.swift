//
//  MyAddressesCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 15/01/25.
//


import Foundation
import Stinsen
import SwiftUI

final class MyAddressCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<MyAddressCoordinator>
    
    @Root var start = makeStart
    @Route(.push) var addAddress = makeAddAddress
    
    
    @ViewBuilder
    func makeStart(viewModel: MyAddressesViewModel) -> some View {
        MyAddressesScreen(viewModel: viewModel)
    }
    func makeAddAddress(viewModel: AddAddressViewModel) -> some View {
        AddAddressScreen(viewModel: viewModel)
    }
    
    init(_ viewModel: MyAddressesViewModel) {
        stack = .init(initial: \.start, viewModel)
        
    }
}
