//
//  CreatingAccountCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class CreatingAccountCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<CreatingAccountCoordinator>
    
    @Root var start = makeStart
    
    @ViewBuilder
    func makeStart(viewModel: CreatingAccountViewModel) -> some View {
        CreatingAccountScreen(viewModel: viewModel)
    }
    
    init(_ viewModel: CreatingAccountViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
}
