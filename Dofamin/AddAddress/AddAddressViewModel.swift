//
//  AddAddressViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 26/12/24.
//

import Foundation
import Combine

class AddAddressViewModel: ObservableObject {
    @Published var address: AddAddressModel.Address
    
    @Published var isAddressChanged = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var buttonTitle: String {
        if address.isAdded {
            return isAddressChanged ? "Сохранить" : "Удалить"
        }
        else {
            return "Добавить"
        }
    }
    
    func add() {
        address.isLoading = true
        APIManager.shared.addAddress(city: address.city, details: address.details, landmark: address.landmark)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                address = AddAddressModel.Address(response: response)
                isAddressChanged = false
            }
            .store(in: &cancellables)
    }
    
    func update() {
        guard let id = address.id else { return }
        address.isLoading = true
        APIManager.shared.updateAddress(id: id, city: address.city, details: address.details, landmark: address.landmark)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                address = AddAddressModel.Address(response: response)
                isAddressChanged = false
            }
            .store(in: &cancellables)
    }
    
    func delete() {
        guard let id = address.id else { return }
        address.isLoading = true
        APIManager.shared.deleteAddress(id: id)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] _ in
                guard let self = self else { return }
                address.isLoading = false
                address.id = nil
                isAddressChanged = false
            }
            .store(in: &cancellables)
        
    }
    
    init(
        address: AddAddressModel.Address = AddAddressModel.Address(
            city: "",
            details: "",
            landmark: ""
        )
    ) {
        self.address = address
        
        $address
            .dropFirst()
            .sink { [weak self] address in
                guard let self = self, address.isAdded else { return }
                isAddressChanged = true
            }
            .store(in: &cancellables)
    }
}
