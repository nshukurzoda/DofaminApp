//
//  MyAddressesViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 26/12/24.
//
import Foundation
import Stinsen
import Combine

class MyAddressesViewModel: ObservableObject {
    @RouterObject var router: MyAddressCoordinator.Router?
    
    @Published var addresses: [AddressResponse] = []
    @Published var isLoading = false
    
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
            }
            .store(in: &cancellables)

    }
    
 
    func route(to route: MyAddressesModel.Route) {
        switch route {
        case let .addAddress(address):
            if let address {
                router?.route(to: \.addAddress, AddAddressViewModel(address: AddAddressModel.Address(response: address)))
            }
            else {
                router?.route(to: \.addAddress, AddAddressViewModel())
            }
        }
    }
}
