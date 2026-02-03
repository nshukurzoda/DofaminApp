//
//  CatalogCoordinator .swift
//  Dofamin
//
//  Created by Nodira Shukurova on 11/01/25.
//


import Foundation
import Stinsen
import SwiftUI

final class CatalogCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<CatalogCoordinator>
    
    @Root var start = makeStart
    
    @Route (.push) var product = makeProduct
    
    @ViewBuilder
    func makeStart(viewModel: CatalogViewModel) -> some View {
        CatalogScreen(viewModel: viewModel)
    }

    func makeProduct(viewModel: ProductViewModel) -> ProductCoordinator {
        ProductCoordinator(viewModel)
    }
    
    init(_ viewModel: CatalogViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
    
  
}
 
