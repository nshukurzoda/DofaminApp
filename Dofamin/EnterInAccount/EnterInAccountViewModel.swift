//
//  EnterInAccountViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 02/01/25.
//

import Foundation
import Stinsen
import Combine

class EnterInAccountViewModel: ObservableObject {
    @RouterObject var router: EnterInAccountCooordinator.Router?
    
    @Published var data = EnterInAccountModel.Data(
        number: "",
        password: "",
        button: ""
    )
    
    @Published var loading: Bool = false
    @Published var error = EnterInAccountModel.Error()
    
    init() {
        $data.sink { [weak self] data in
            guard let self, data.number.count >= 10 else { return }
            self.data.number = data.number.prefix(9).description
        }
        .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        loading = true
        APIManager.shared.login(phoneNumber: data.number, password: data.password)
            .sink { [weak self] completion in
                guard let self else { return }
                loading = false
                if case let .failure(error) = completion {
                    print(error)
                    self.error = EnterInAccountModel.Error(error: error)
                    
                }
            } receiveValue: { tokenResponse in
                KeychainManager.shared.token = tokenResponse.token
                AuthenticationService.shared.status = .idle
            }
            .store(in: &cancellables)
        
    }
}


extension EnterInAccountViewModel {
    func routeToCatalog() {
        router?.route(to: \.catalog, CatalogViewModel())
        
    }
}


