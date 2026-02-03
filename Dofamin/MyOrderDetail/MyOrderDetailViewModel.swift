//
//  OrderDetailViewModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 24/12/24.
//

import Foundation

class OrderDetailViewModel: ObservableObject {
    @Published var orders: [OrderDetailModel.Order] = []
    @Published var orderData: OrderDetailModel.OrderData
    
    init(response: OrderResponse) {
        self.orders = response.products.map { .init(response: $0) }
        self.orderData = .init(
            id: response.id,
            address: response.deliveryAddress?.details ?? "",
            price: response.products.reduce(0, { $0 + Double($1.quantity) * $1.price }),
            status: response.orderStatus
        )
    }
}
