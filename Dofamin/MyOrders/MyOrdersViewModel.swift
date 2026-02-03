//
//  MyOrdersViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 20/12/24.
//
import Foundation
import Combine
import Stinsen

class MyOrdersViewModel: ObservableObject{
    @Published private var allOrders: [MyOrdersModel.Order] = []
    var orders: [MyOrdersModel.Order] {
        switch selectedOrderStatus {
        case .history:
            return allOrders
        case .onRoad:
            return allOrders.filter { $0.status == .onRoad }
        case .pending:
            return allOrders.filter { $0.status == .pending }
        }
    }
    
    @Published var isLoading: Bool = false
    @Published var selectedOrderStatus = MyOrdersModel.Status.onRoad
    
    @RouterObject var router: MyOrdersCoordinator.Router?
    
    var cancellables = Set<AnyCancellable>()
    
    func getOrders() {
        isLoading = true
        APIManager.shared.getOrders()
            .map { $0.map { MyOrdersModel.Order(response: $0) } }
            .sink { completion in
                guard case let .failure(error) = completion else { return }
                print(error)
            } receiveValue: { [weak self] orders in
                guard let self = self else { return }
                isLoading = false
                allOrders = orders
            }
            .store(in: &cancellables)
    }
}

extension MyOrdersViewModel {
    func route(to route: MyOrdersModel.Route) {
        switch route {
        case .orderDetail(let order):
            router?.route(to: \.orderDetail, OrderDetailViewModel(response: order.response))
        }
    }
}
