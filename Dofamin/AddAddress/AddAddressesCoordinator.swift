//
//  AddAddressCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 15/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class AddAddressesCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<AddAddressesCoordinator>
    
    @Root var start = makeStart
  
    
    @ViewBuilder
    func makeStart(viewModel: AddAddressViewModel) -> some View {
        AddAddressScreen(viewModel: viewModel)
    }
    init(_ viewModel: AddAddressViewModel) {
        stack = .init(initial: \.start, viewModel)
        
    }
}
