//
//  EnterInAccountCooordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 10/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class EnterInAccountCooordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<EnterInAccountCooordinator>
    
    @Root var start = makeStart
    @Route(.push) var catalog = makeCatalog

    @ViewBuilder
    func makeStart(viewModel: EnterInAccountViewModel) -> some View {
        EnterInAccountScreen(viewModel: viewModel)
    }
    func makeCatalog(viewModel: CatalogViewModel) -> some View {
        CatalogScreen(viewModel: viewModel)
    }
    
    init(_ viewModel: EnterInAccountViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
}
