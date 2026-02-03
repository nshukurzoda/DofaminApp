//
//  ProductViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 10/12/24.
//

import SwiftUI
import Combine
import Stinsen

class ProductViewModel: ObservableObject {
    @Published var products: [ProductModel.Product] = []
    @Published var subCategories: [ProductModel.SubCategory] = []
    @Published var filter = ProductModel.Filter(searchText: "")
    @Published var isLoading = false
    @Published var isFilterPresented = false
    
    @RouterObject var router: ProductCoordinator.Router?
    
    private let categoryId: Int
    
    private let pageSize = 20
    private var pageNumber = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    func getSubCategories() {
        APIManager.shared.getSubCategories(categoryId: categoryId)
            .map { arrayResponse in
                arrayResponse.map { ProductModel.SubCategory(response: $0) }
            }
            .sink(receiveCompletion: { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            }) { [weak self] subCategories in
                guard let self = self else { return }
                self.subCategories = subCategories
            }
            .store(in: &cancellables)
    }
    
    func getProducts(filter: ProductModel.Filter) {
        self.products.removeAll()
        pageNumber = 0
        isLoading = true
        APIManager.shared.getCategoriesDetails(
            name: filter.searchText,
            categoryId: categoryId,
            subCategoryId: filter.subCategory?.id,
            orderByPrice: filter.productType.rawValue,
            pageNumber: pageNumber,
            pageSize: pageSize
        )
        .map { response in
            response.data.map { ProductModel.Product(response: $0) }
        }
        .sink { completion in
            guard case let .failure(error) = completion else { return }
            print(error)
        } receiveValue: { [weak self] products in
            guard let self = self else { return }
            self.products = products
            self.isLoading = false
        }
        .store(in: &cancellables)
    }
    
    func isLast(product: ProductModel.Product) -> Bool { products.last == product }
    
    func getNextProducts() {
        guard pageSize * pageNumber <= products.count else { return }
        isLoading = true
        pageNumber += 1
        APIManager.shared.getCategoriesDetails(
            name: filter.searchText,
            categoryId: categoryId,
            subCategoryId: filter.subCategory?.id,
            orderByPrice: filter.productType.rawValue,
            pageNumber: pageNumber,
            pageSize: pageSize
        )
        .map { response in
            response.data.map { ProductModel.Product(response: $0) }
        }
        .sink { completion in
            guard case let .failure(error) = completion else { return }
            print(error)
        } receiveValue: { [weak self] products in
            guard let self = self else { return }
            self.products += products
            isLoading = false
        }
        .store(in: &cancellables)
    }
    
    func update() {
        $filter.dropFirst().removeDuplicates().sink { [weak self] (filter) in
            guard let self = self else { return }
            getProducts(filter: filter)
        }
        .store(in: &cancellables)
    }
    
    init(categoryId: Int) {
        self.categoryId = categoryId
        update()
    }
    
    
    func deleteFromCart(id: Int) {
        guard let index = products.firstIndex(where: { $0.id == id }), let cartId = products[index].cartId else { return }
        products[index].isAddedToCart = false
        products[index].cartId = nil
        
        APIManager.shared.deleteFromCart(id: cartId)
            .sink { _ in } receiveValue: { _ in }.store(in: &cancellables)
    }
    
    func addToCart(id: Int) {
        guard let index = products.firstIndex(where: { $0.id == id }) else { return }
        products[index].isAddedToCart = true
        APIManager.shared.addToCart(productId: id, quantity: 1)
            .sink { _ in } receiveValue: { [weak self] resposne in
                guard let self = self else { return }
                products[index].cartId = resposne.id
            }
            .store(in: &cancellables)
    }
}

extension ProductViewModel {
    func route(to route: ProductModel.Route) {
        switch route {
        case let .product(product):
            router?.route(to: \.product, ProductDetailViewModel(id: product.id))
        }
    }
}
