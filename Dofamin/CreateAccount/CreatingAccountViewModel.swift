//
//  CreatingAccountViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 02/01/25.
//

import Foundation
import Combine

class CreatingAccountViewModel: ObservableObject {
    @Published var account = CreatingAccountModel.AccountData(
        name: "",
        phoneNumber: "",
        password: ""
    )
    @Published var loading: Bool = false
    @Published var error = CreatingAccountModel.Error()
    
    var strings: Strings!
    
    private var cancellables = Set<AnyCancellable>()
    
    func setup(strings: Strings) {
        self.strings = strings
    }
    
    func create() {
        loading = true
        APIManager.shared.register(fullName: account.name, phone: account.phoneNumber, password: account.password)
            .sink { [weak self] completion in
                guard let self else { return }
                loading = false
                if case let .failure(error) = completion {
                    self.error = .init(error: error)
                }
            } receiveValue: { tokenResponse in
                KeychainManager.shared.token = tokenResponse.token
                AuthenticationService.shared.status = .idle
            }
            .store(in: &cancellables)

    }
}
