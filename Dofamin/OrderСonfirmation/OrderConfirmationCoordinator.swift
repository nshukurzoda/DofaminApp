//
//  OrderConfirmationCoordinator.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 07/02/25.
//

import Foundation
import Stinsen
import SwiftUI

final class OrderConfirmationCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<OrderConfirmationCoordinator>
    
    @Root var start = makeStart
    @Root var orderAccept = makeOrderAccept
    
    @Route(.push) var deliveryMethod = makeDeliveryMethod
    
    @ViewBuilder
    func makeOrderAccept() -> some View {
        OrderAcceptScreen()
    }
    
    @ViewBuilder
    func makeStart(viewModel: OrderConfirmationViewModel) -> some View {
        OrderConfirmationScreen(viewModel: viewModel)
    }
    
    func makeDeliveryMethod(viewModel: DeliveryMethodViewModel) -> DeliveryMethodCoordinator {
        DeliveryMethodCoordinator(viewModel)
    }
    
    init(_ viewModel: OrderConfirmationViewModel) {
        self.stack = .init(initial: \.start, viewModel)
    }
}
