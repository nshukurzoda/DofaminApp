//
//  ProductModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/12/24.
//

import SwiftUI

struct ProductModel {
    struct SubCategory: Identifiable, Equatable {
        let id: Int
        let name: String
        
        init(response: SubCategoryResponse) {
            self.name = response.name
            self.id = response.id
        }
    }
    
    struct Filter: Equatable {
        var searchText: String
        var subCategory: SubCategory?
        var productType: ProductType = .popular
    }
    
    enum ProductType: Int, CaseIterable {
        case popular = 0
        case expensive = 1
        case cheap = 2
        
        var title: String {
            switch self {
            case .popular:
                "Самые популярные"
            case .expensive:
                "Самые дорогие"
            case .cheap:
                "Самые дешёвые"
            }
        }
    }
    
    struct Product: Identifiable, Equatable {
        let id: Int
        let name: String
        let description: String
        let price: Double
        let image: URL?
        let subCategoryId: Int
        let quantity: Int
        var isAvailable: Bool {
            quantity > 0
        }
        var isAddedToCart: Bool = false
        var cartId: Int? = nil
        
        init(response: ProductResponse) {
            self.id = response.id
            self.name = response.name
            self.description = response.description ?? ""
            self.price = response.price
            self.image = response.imageUrls.first
            self.subCategoryId = response.subCategoryId
            self.quantity = response.quantity
        }
        
        func isMatch(by filter: Filter) -> Bool {
            let searchTextFlag = matchesPattern(name, pattern: filter.searchText)
            let subCategoryFlag = filter.subCategory?.id == subCategoryId || filter.subCategory == nil
            print(searchTextFlag, subCategoryFlag)
            return searchTextFlag && subCategoryFlag
        }
        
        func matchesPattern(_ text: String, pattern: String) -> Bool {
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
                let range = NSRange(location: 0, length: text.utf16.count)
                return regex.firstMatch(in: text, options: [], range: range) != nil
            } catch {
                print("Ошибка при создании регулярного выражения: \(error)")
                return true
            }
        }
    }
    
    enum Route {
        case product(Product)
    }
}
