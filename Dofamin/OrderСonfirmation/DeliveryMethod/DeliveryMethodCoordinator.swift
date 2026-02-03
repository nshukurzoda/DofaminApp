//
//  DeliveryMethodCoordinator.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 09/02/25.
//

import Foundation
import Stinsen
import SwiftUI

final class DeliveryMethodCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<DeliveryMethodCoordinator>
    
    @Root var start = makeStart
    
    @Route(.push) var addAddress = makeAddAddress
    
    @ViewBuilder
    func makeStart(viewModel: DeliveryMethodViewModel) -> some View {
        DeliveryMethodScreen(viewModel: viewModel)
    }
    
    func makeAddAddress(viewModel: AddAddressViewModel) -> some View {
        AddAddressScreen(viewModel: viewModel)
    }
    
    init(_ viewModel: DeliveryMethodViewModel) {
        self.stack = .init(initial: \.start, viewModel)
    }
}
