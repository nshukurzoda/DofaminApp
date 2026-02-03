//
//  MyOrdersModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 20/12/24.
//

import Foundation
struct MyOrdersModel {
    struct Order: Identifiable {
        let id: Int
        let products: [URL]
        let status: OrdersStatus
        let date: Date
        
        let response: OrderResponse
        
        init(response: OrderResponse) {
            self.id = response.id
            self.products = response.products.compactMap { $0.imageUrls.first }
            self.status = response.orderStatus
            self.response = response
            self.date = response.orderDate
        }
    }
    
    enum Status: CaseIterable {
        case onRoad
        case pending
        case history
        
        var title: String {
            switch self {
            case .onRoad:
                return "В пути"
            case .history:
                return "История"
            case .pending:
                return "В ожидании"
            }
        }
    }
    
    enum Route {
        case orderDetail(Order)
    }
}
