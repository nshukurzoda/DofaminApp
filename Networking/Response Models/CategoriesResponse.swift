//
//  CategoriesResponse.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 27/01/25.
//

import Foundation

typealias CategoriesResponse = [CategoryResponse]

struct CategoryResponse: Decodable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let productCount: Int
}

struct SubCategoryResponse: Decodable {
    let id: Int
    let name: String
}

typealias SubCategoriesResponse = [SubCategoryResponse]

struct ProductsResponse: Decodable {
    let data: [ProductResponse]
}
