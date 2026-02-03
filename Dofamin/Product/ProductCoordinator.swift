//
//  ProductCoordinator.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 01/02/25.
//

import Foundation
import Stinsen
import SwiftUI

final class ProductCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<ProductCoordinator>
    
    @Root var start = makeStart
    
    @Route(.push) var product = makeProduct
    
    @ViewBuilder
    func makeStart(viewModel: ProductViewModel) -> some View {
        ProductScreen(viewModel: viewModel)
    }
    
    func makeProduct(viewModel: ProductDetailViewModel) -> ProductDetailCoordinator {
        ProductDetailCoordinator(viewModel)
    }
    
    init(_ viewModel: ProductViewModel) {
        self.stack = .init(initial: \.start, viewModel)
    }
}
