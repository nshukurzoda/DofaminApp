//
//  ProfileViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 14/12/24.
//

import Foundation
import SwiftUI
import Stinsen
import CoreData
import Combine

class ProfileViewModel: ObservableObject {
    @RouterObject var router: ProfileCoordinator.Router?
    
    @Published var profile: ProfileModel.Profile = .empty
    @Published var isExitDialogPresented = false
    @Published var isRemoveAccountPresented = false
    @Published var selectedImage: UIImage?
    
    private var cancellables = Set<AnyCancellable>()
    
    func getProfile() {
        guard let user = KeychainManager.shared.user else { return }
        profile = ProfileModel.Profile(user: user)
        $selectedImage
            .compactMap { $0 }
            .sink { [weak self] image in
                guard let self = self, let imageData = image.pngData() else { return }
                APIManager.shared.changeAvatar(imageData: imageData)
                    .map { $0.url }
                    .sink(receiveCompletion: {_ in }, receiveValue: { [weak self] url in
                        guard let self = self else { return }
                        KeychainManager.shared.user?.avatar = url
                        profile.avatar = url
                    })
                    .store(in: &cancellables)
            }
            .store(in: &cancellables)
    }
    
    func removeAccount() {
        APIManager.shared.removeAccount()
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
        KeychainManager.shared.clear()
        AuthenticationService.shared.status = .unauthenticated
    }
}
extension ProfileViewModel {
    func route(to route: ProfileModel.Route) {
        switch route {
        case .myOrders:
            router?.route(to: \.myOrders, MyOrdersViewModel())
        case .myProfile:
            if let user = KeychainManager.shared.user {
                router?.route(to: \.myProfile, MyProfileViewModel(user: user))
            }
        case.myAddresses:
            router?.route(to: \.myAddresses, MyAddressesViewModel())
        }
    }
}
