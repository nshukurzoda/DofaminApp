//
//  RegistrationCoordinator.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/01/25.
//

import Foundation
import Stinsen
import SwiftUI

final class RegistrationCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<RegistrationCoordinator>
    
    @Root var start = makeStart
    
    @Route(.push) var creatingAccount = makeCreatingAccount
    @Route(.push)  var  enterInAccount = makeEnterInAccount
    
    @ViewBuilder
    func makeStart(viewModel: RegistrationViewModel) -> some View {
        RegistrationScreen(viewModel: viewModel)
    }
    
    func makeCreatingAccount(viewModel: CreatingAccountViewModel) -> some View {
        CreatingAccountScreen(viewModel: viewModel)
    }
    func makeEnterInAccount(viewModel: EnterInAccountViewModel) -> some View {
        EnterInAccountScreen(viewModel: viewModel)
    }
    
    init(_ viewModel: RegistrationViewModel) {
        stack = .init(initial: \.start, viewModel)
    }
    
}
