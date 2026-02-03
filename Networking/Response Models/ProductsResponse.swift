//
//  Products.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 03/02/25.
//

import Foundation

struct ProductResponse: Decodable {
    let id: Int
    let quantity: Int
    let name: String
    let description: String?
    let subCategoryName: String?
    let price: Double
    let imageUrls: [URL]
    let subCategoryId: Int
}

struct CartResponse: Decodable {
    let cartItems: [CartProductResponse]
    let adresses: [AddressResponse]
}

struct CartProductResponse: Decodable {
    let id: Int
    let quantity: Int
    let product: ProductResponse
}

struct AddToCartResponseWrapped: Decodable {
    let entity: AddToCartResponse
}

struct AddToCartResponse: Decodable {
    let id: Int
}
