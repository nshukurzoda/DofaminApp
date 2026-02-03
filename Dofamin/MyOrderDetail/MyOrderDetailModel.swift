//
//  OrderDetailModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 24/12/24.
//

import Foundation
import SwiftUI

struct OrderDetailModel {
    struct Order: Identifiable {
        let id: Int
        let quantity: Int
        let product: Product
        
        init(response: ProductResponse) {
            self.id = response.id
            self.product = Product(response: response)
            self.quantity = response.quantity
        }
        
        init(id: Int, quantity: Int, product: Product) {
            self.id = id
            self.quantity = quantity
            self.product = product
        }
    }
    
    struct Product {
        let id: Int
        let name: String
        let price: Double
        let image: URL?
        let subCategoryName: String?
        
        init(response: ProductResponse) {
            self.id = response.id
            self.name = response.name
            self.price = response.price
            self.image = response.imageUrls.first
            self.subCategoryName = response.subCategoryName
        }
    }
    
    struct OrderData {
        let id: Int
        let address: String
        let price: Double
        let status: OrdersStatus
    }
    
}
