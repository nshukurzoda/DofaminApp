//
//  MyProfileViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 14/12/24.
//

import Foundation
import Combine
import Stinsen

class MyProfileViewModel: ObservableObject {
    @Published var profile: MyProfileModel.Profile
    
    @RouterObject var router: MyProfileCoordinator.Router?
    
    private var cancellables = Set<AnyCancellable>()
    
    func update() {
        profile.isLoading = true
        APIManager.shared.updateProfile(name: profile.name, phoneNumber: profile.number, password: "")
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                profile.isLoading = false
                KeychainManager.shared.user = .init(response: response)
                router?.dismissCoordinator()
            }
            .store(in: &cancellables)

    }
    
    init(user: User) {
        profile = MyProfileModel.Profile(user: user)
    }
}
