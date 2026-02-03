//
//  SplashViewModel.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 03/02/25.
//

import Foundation
import Combine
import CoreData
import Moya

class SplashViewModel: ObservableObject, Equatable {
    static func == (lhs: SplashViewModel, rhs: SplashViewModel) -> Bool {
        lhs === rhs
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var error = SplashModel.Error()
    
    func checkAuth() {
        guard KeychainManager.shared.token != nil else {
            AuthenticationService.shared.status = .onboarding
            return
        }
        
        if KeychainManager.shared.user != nil {
            AuthenticationService.shared.status = .authenticated
        }
        else {
            APIManager.shared.getMe()
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    AuthenticationService.shared.status = .authenticated
                }) { response in
                    KeychainManager.shared.user = User(response: response)
                }
                .store(in: &cancellables)
        }
        
    }
}

struct SplashModel {
    struct Error {
        var message: String
        var isPresented: Bool
        
        init() {
            self.isPresented = false
            self.message = ""
        }
        
        init(error: MoyaError) {
            self.isPresented = true
            self.message = ErrorWrapper(error: error).message
        }
    }
}
