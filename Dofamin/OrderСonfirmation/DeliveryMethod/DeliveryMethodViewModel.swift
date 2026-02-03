//
//  DeliveryMethodViewModel.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 09/02/25.
//

import Foundation
import Combine
import Stinsen

class DeliveryMethodViewModel: ObservableObject {
    @Published var addresses: [AddressResponse] = []
    @Published var selectedAddress: AddressResponse?
    @Published var isLoading = false
    
    @RouterObject var router: DeliveryMethodCoordinator.Router?
    
    private var cancellables = Set<AnyCancellable>()
    
    func getAddresses() {
        isLoading = true
        APIManager.shared.getCart()
            .map { $0.adresses }
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] addresses in
                guard let self = self else { return }
                self.addresses = addresses
                self.isLoading = false
                if selectedAddress == nil {
                    self.selectedAddress = addresses.last
                }
            }
            .store(in: &cancellables)

    }
    
    init(addresses: [AddressResponse], selectedAddress: AddressResponse?) {
        self.addresses = addresses
        self.selectedAddress = selectedAddress
    }
}

extension DeliveryMethodViewModel {
    func route(to route: DeliveryMethodModel.Route) {
        switch route {
        case .addAddress:
            router?.route(to: \.addAddress, AddAddressViewModel())
        }
    }
}

struct DeliveryMethodModel {
    enum Route {
        case addAddress
    }
}
