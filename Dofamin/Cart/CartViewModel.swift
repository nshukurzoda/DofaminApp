//
//  CartViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 26/12/24.
//

import Foundation
import Combine
import Stinsen

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartModel.Cart] = []
    @Published var selectedCartOption: CartModel.Cart?
    @Published var isLoading = false
    
    @RouterObject var router: CartCoordinator.Router?
    
    private var addresses: [AddressResponse] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func getCart() {
        isLoading = true
        APIManager.shared.getCart()
            .map { response in
                (
                    response.cartItems.map { CartModel.Cart(response: $0) },
                    response.adresses
                )
            }
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            }) { [weak self] (cartItems, addresses) in
                guard let self = self else { return }
                self.cartItems = cartItems
                self.addresses = addresses
                for index in addresses.indices {
                    self.addresses[index].deliveryMethodId = 2
                }
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func addCount(for cart: CartModel.Cart) {
        guard let index = cartItems.firstIndex(where: { $0.id == cart.id }), cart.quantity < cart.product.quantity else { return }
        cartItems[index].quantity += 1
        APIManager.shared.updateCart(id: cart.id, productId: cart.product.id, quantity: cart.quantity )
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func removeCount(for cart: CartModel.Cart) {
        guard let index = cartItems.firstIndex(where: { $0.id == cart.id }), cart.quantity > 1 else { return }
        cartItems[index].quantity -= 1
        APIManager.shared.updateCart(id: cart.id, productId: cart.product.id, quantity: cart.quantity)
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}

extension CartViewModel {
    func route(to route: CartModel.Route) {
        switch route {
        case let .productDetail(cart):
            router?.route(
                to: \.productDetail,
                ProductDetailViewModel(
                    id: cart.product.id,
                    cartId: cart.id,
                    count: cart.quantity
                )
            )
        case .orderConfirmation:
            let amount = cartItems.reduce(0, { $0 + $1.product.price * Double($1.quantity) })
            let viewModel = OrderConfirmationViewModel(amount: amount, addresses: addresses, onAccept: { [weak self] in
                self?.cartItems = []
            })
            
            viewModel.$addresses.sink { [weak self] addresses in
                guard let self = self else { return }
                self.addresses = addresses
            }
            .store(in: &cancellables)
            
            router?.route(to: \.orderConfirmation, viewModel)
        }
    }
}

struct AddressResponse: Decodable, Equatable {
    let id: Int
    let landmark: String
    let city: String
    let details: String
    
    var deliveryMethodId: Int = 2
    
    enum CodingKeys: String, CodingKey {
        case id
        case landmark
        case city
        case details = "addressDetails"
    }
}
