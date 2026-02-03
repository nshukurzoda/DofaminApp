//
//  ProductDetailViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 11/12/24.
//

import Foundation
import Combine
import Stinsen

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductDetailModel.Product = .empty
    @Published var count: Int
    @Published var isLoadingToCart = false
    @Published var isCountChanged = false
    @Published var isLoading = false
    
    @RouterObject var router: ProductDetailCoordinator.Router?
    
    var buttonTitle: String {
        if isAddedToCart {
            return isCountChanged ? "Сохранить" : "Убрать из корзины"
        }
        else {
            return "Добавить в корзину"
        }
    }
    
    var isAddedToCart: Bool {
        cartId != nil
    }
    
    private let productId: Int
    private var cartId: Int?
    
    private var cancellables = Set<AnyCancellable>()
    
    func getProduct() {
        $count
            .dropFirst()
            .sink { [weak self] count in
                guard let self = self, isAddedToCart else { return }
                isCountChanged = true
            }
            .store(in: &cancellables)
        isLoading = true
        APIManager.shared.getProduct(id: productId)
            .map { ProductDetailModel.Product(response: $0) }
            .sink(receiveCompletion: { _ in }) { [weak self] product in
                guard let self = self else { return }
                self.product = product
                isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updateCart() {
        guard let id = cartId else { return }
        isLoadingToCart = true
        APIManager.shared.updateCart(id: id, productId: product.id, quantity: count)
            .sink { [weak self] completion in
                guard let self = self else { return }
                isLoadingToCart = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                isCountChanged = false
            }
            .store(in: &cancellables)
    }
    
    func deleteFromCart() {
        guard let id = cartId else { return }
        isLoadingToCart = true
        APIManager.shared.deleteFromCart(id: id)
            .sink { [weak self] completion in
                guard let self = self else { return }
                isLoadingToCart = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                cartId = nil
            }
            .store(in: &cancellables)
    }
    
    func addToCart() {
        isLoadingToCart = true
        APIManager.shared.addToCart(productId: product.id, quantity: count)
            .sink { [weak self] completion in
                guard let self = self else { return }
                isLoadingToCart = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                cartId = response.id
            }
            .store(in: &cancellables)
    }
    
    init(id: Int, cartId: Int? = nil, count: Int = 1) {
        self.productId = id
        self.count = count
        self.cartId = cartId
    }
}
