//
//  MyOrdersCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 16/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class MyOrdersCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack <MyOrdersCoordinator>
    
    @Root var start = makeStart
    
    @Route(.push) var orderDetail = makeOrderDetail
    
    @ViewBuilder
    func makeStart(viewModel: MyOrdersViewModel) -> some View {
        MyOrdersScreen(viewModel: viewModel)
    }
    
    func makeOrderDetail(viewModel: OrderDetailViewModel) -> OrderDetailCoordinator {
        OrderDetailCoordinator(viewModel)
    }
    
    
    init(_ viewModel: MyOrdersViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
}
