//
//  CartCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 12/01/25.
//

import Foundation
import Stinsen
import SwiftUI
final class CartCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<CartCoordinator>
    
    @Root var start = makeStart
    
    @Route(.push) var productDetail = makeProductDetail
    @Route(.modal) var orderConfirmation = makeOrderConfirmation
    
    @ViewBuilder
    func makeStart(viewModel: CartViewModel) -> some View {
        CartScreen(viewModel: viewModel)
    }
    
    func makeProductDetail(viewModel: ProductDetailViewModel) -> ProductDetailCoordinator {
        ProductDetailCoordinator(viewModel)
    }
    
    func makeOrderConfirmation(viewModel: OrderConfirmationViewModel) -> NavigationViewCoordinator<OrderConfirmationCoordinator> {
        NavigationViewCoordinator(OrderConfirmationCoordinator(viewModel))
    }
    
    init(_ viewModel: CartViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
}


