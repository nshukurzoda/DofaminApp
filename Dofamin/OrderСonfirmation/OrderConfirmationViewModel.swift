//
//  OrderConfirmationViewModel.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 06/02/25.
//

import Foundation
import Combine
import Stinsen

class OrderConfirmationViewModel: ObservableObject {
    @Published var note: String = ""
    @Published var selectedAddress: AddressResponse?
    @Published var isOrderLoading: Bool = false
    @Published var addresses: [AddressResponse]
    
    var onAccept: () -> Void
    
    var isAvailable: Bool {
        selectedAddress != nil
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @RouterObject var router: OrderConfirmationCoordinator.Router?
    
    let amount: Double
    
    init(amount: Double, addresses: [AddressResponse], onAccept: @escaping () -> Void) {
        self.selectedAddress = addresses.last
        self.amount = amount
        self.addresses = addresses
        self.onAccept = onAccept
    }
    
    func order() {
        guard let id = selectedAddress?.id,
              let deliveryMethodId = selectedAddress?.deliveryMethodId
        else { return }
        isOrderLoading = true
        APIManager.shared.orderProduct(deliveryMethodId: deliveryMethodId, deliveryAddressId: id, orderNotes: note)
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                isOrderLoading = false
                onAccept()
                router?.root(\.orderAccept)
            }
            .store(in: &cancellables)

    }
}

extension OrderConfirmationViewModel {
    func route(to route: OrderConfirmationModel.Route) {
        switch route {
        case .deliveryMethod:
            let viewModel = DeliveryMethodViewModel(addresses: addresses, selectedAddress: selectedAddress)
            viewModel.$selectedAddress.sink { [weak self] address in
                guard let self = self else { return }
                selectedAddress = address
            }
            .store(in: &cancellables)
            
            viewModel.$addresses.sink { [weak self] addresses in
                guard let self = self else { return }
                self.addresses = addresses
            }
            .store(in: &cancellables)
            
            router?.route(to: \.deliveryMethod, viewModel)
        case .previous:
            router?.dismissCoordinator()
        }
    }
}
