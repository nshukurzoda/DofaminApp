//
//  cartModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 26/12/24.
//

import Foundation
struct CartModel {
    struct Cart: Identifiable {
        static let empty = Cart(id: 0, quantity: 1, product: Product(id: 2, name: "temp", price: 3, image: nil))
        
        let id: Int
        var quantity: Int
        let product: Product
        
        init(response: CartProductResponse) {
            self.id = response.id
            self.product = Product(response: response.product)
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
        let subCategoryName: String?
        let price: Double
        let image: URL?
        let quantity: Int
        
        init(response: ProductResponse) {
            self.quantity = response.quantity
            self.id = response.id
            self.name = response.name
            self.price = response.price
            self.image = response.imageUrls.first 
            self.subCategoryName = response.subCategoryName
        }
        
        init(id: Int, name: String, price: Double, image: URL?) {
            self.id = id
            self.name = name
            self.price = price
            self.image = image
            self.subCategoryName = nil
            self.quantity = 1
        }
    }
    
    enum Route {
        case productDetail(Cart)
        case orderConfirmation
    }
}
