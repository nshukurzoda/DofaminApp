//
//  OrderResponse.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 12/02/25.
//

import Foundation
import SwiftUI

struct OrderResponse: Decodable {
    let id: Int
    let deliveryAddressId: Int?
    let orderStatus: OrdersStatus
    let products: [ProductResponse]
    let orderDate: Date
    
    var deliveryAddress: AddressResponse?
}

enum OrdersStatus: Int, Decodable, CaseIterable {
    case pending = 1
    case delivered = 2
    case onRoad = 4
    
    var title: String {
        switch self {
        case .pending:
            "В ожидании"
        case .delivered:
            "Доставлено"
        case .onRoad:
            "В пути"
        }
    }
    
    func textColor(for colors: DesignColors) -> Color {
        switch self {
        case .pending:
            colors.textWarning2
        case .delivered:
            colors.textSuccess2
        case .onRoad:
            colors.textWarning2
        }
    }
    
    
    func backgroundColor(for colors: DesignColors) -> Color {
        switch self {
        case .pending:
            colors.bgWarning1
        case .delivered:
            colors.bgSuccess1
        case .onRoad:
            colors.bgWarning1
        }
    }
}
