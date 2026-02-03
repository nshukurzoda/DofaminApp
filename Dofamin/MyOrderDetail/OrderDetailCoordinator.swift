//
//  OrderDetailCoordinator.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 12/02/25.
//

import Foundation
import Stinsen
import SwiftUI

final class OrderDetailCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<OrderDetailCoordinator>
    
    @Root var start = makeStart
    
    @ViewBuilder func makeStart(viewModel: OrderDetailViewModel) -> OrderDetailScreen {
        OrderDetailScreen(viewModel: viewModel)
    }
    
    init(_ viewModel: OrderDetailViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
}
