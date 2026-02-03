//
//  RegistrationViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 30/12/24.
//
import Foundation
import Stinsen

class RegistrationViewModel: ObservableObject, Equatable {
    @RouterObject var router: RegistrationCoordinator.Router?

    static func == (lhs: RegistrationViewModel, rhs: RegistrationViewModel) -> Bool {
        return lhs === rhs
    }
    
    
}

extension RegistrationViewModel {
    func route(to route: RegistrationModel.Route) {
        switch route {
        case .creatingAccount:
            router?.route(to: \.creatingAccount, CreatingAccountViewModel())
        case .enterInAccount:
            router?.route(to: \.enterInAccount, EnterInAccountViewModel())
        }
    }
}
