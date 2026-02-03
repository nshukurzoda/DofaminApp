//
//  ProductDetailModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 11/12/24.
//

import Foundation

struct ProductDetailModel{
    struct Product {
        static let empty = Product(id: 0, name: "", description: "", quantity: 0, price: 0, imageUrls: [])
        
        let id: Int
        let name: String
        let description: String
        let quantity: Int
        let price: Double
        let imageUrls: [URL]
        var isAvailable: Bool {
            quantity > 0
        }
        
        init(response: ProductResponse) {
            self.id = response.id
            self.name = response.name
            self.description = response.description ?? ""
            self.quantity = response.quantity
            self.price = response.price
            self.imageUrls = response.imageUrls
        }
        
        init(
            id: Int,
            name: String,
            description: String,
            quantity: Int,
            price: Double,
            imageUrls: [URL]
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.quantity = quantity
            self.price = price
            self.imageUrls = imageUrls
        }
    }
    
}
   
    
