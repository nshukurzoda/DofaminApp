//
//  ProductDetailCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 17/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class ProductDetailCoordinator: NavigationCoordinatable{
    var stack: Stinsen.NavigationStack<ProductDetailCoordinator>
    
    @Root var start = makeStart
    
    @ViewBuilder
    func makeStart(viewModel: ProductDetailViewModel) -> some View {
        ProductDetailScreen(viewModel: viewModel)
    }
    
    init(_ viewModel:ProductDetailViewModel ) {
        stack = .init(initial: \.start, viewModel)
    }
}


