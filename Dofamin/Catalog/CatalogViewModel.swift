//
//  CatalogViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/12/24.


import Foundation
import Stinsen
import Combine

class CatalogViewModel: ObservableObject {
    @RouterObject var router: CatalogCoordinator.Router?
    
    @Published var catalogs = [CatalogModel.Catalog]()
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func getCatalogs() {
        isLoading = true
        APIManager.shared.getCategories()
            .map { arrayResponse in
                arrayResponse.map { CatalogModel.Catalog(response: $0) }
            }
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] catalogs in
                guard let self = self else { return }
                self.catalogs = catalogs
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}


extension CatalogViewModel {
    func route(to route: CatalogModel.Route) {
        switch route {
        case let .product(catalog):
            router?.route(to: \.product, ProductViewModel(categoryId: catalog.id))
        }
    }
}

