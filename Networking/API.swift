//
//  API.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 23/01/25.
//

import Foundation
import Moya
import UIKit

enum API: TargetType {
    case register(fullName: String, phone: String, password: String)
    case login(phoneNumber: String, passwordHash: String)
    case categories
    case subCategories(id: Int)
    case products(name: String, categoryId: Int, subCategoryId: Int?, orderByPrice: Int,  pageSize: Int, pageNumber: Int)
    case product(id: Int)
    case me
    case addToCart(productId: Int, quantity: Int)
    case deleteFromCart(id: Int)
    case cart
    case updateCart(cartId: Int, productId: Int, quantity: Int)
    case addAddress(city: String, details: String, landmark: String)
    case updateAddress(id: Int, city: String, details: String, landmark: String)
    case deleteAddress(id: Int)
    case orderProduct(paymentMethodId: Int, deliveryMethodId: Int, deliveryAddressId: Int, orderNotes: String)
    case updateProfile(name: String, phoneNumber: String, password: String)
    case changeAvatar(imageData: Data)
    case removeAccount
    
}


extension API {
    
    var baseURL: URL {
        URL(string: "http://147.93.56.106:5005/api/")!
    }
    
    var path: String {
        switch self {
        case .register:
            "auth/register"
        case .login:
            "auth/login"
        case .me:
            "auth/me"
        case .categories:
            "categories/get_active"
        case .subCategories:
            "sub_categories/get_by_category"
        case .products:
            "products/get_by_filters"
        case .product:
            "products/get_by_id"
        case .addToCart:
            "cart/add"
        case .deleteFromCart:
            "cart/delete"
        case .cart:
            "cart/get_user_carts"
        case .updateCart:
            "cart/update"
        case .addAddress:
            "users/add_address"
        case .updateAddress:
            "users/update_address"
        case .deleteAddress:
            "users/remove_address"
        case .orderProduct:
            "orders/add"
        case .updateProfile:
            "users/update_profile"
        case .changeAvatar:
            "users/change_avatar"
        case .removeAccount:
            "users/remove"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register, .login, .addAddress, .orderProduct, .products:
                .post
        case .categories, .product, .products, .me, .cart, .addToCart, .updateCart, .subCategories:
                .get
        case .deleteFromCart, .deleteAddress, .removeAccount:
                .delete
        case .updateAddress, .updateProfile, .changeAvatar:
                .put
        }
    }
    
    
    var task: Moya.Task {
        switch self {
        case let .updateProfile(name, phoneNumber, password):
            return .requestParameters(parameters: ["fullName": name, "phoneNumber": "992" + phoneNumber, "password": password], encoding: JSONEncoding.default)
        case let .orderProduct(paymentMethodId, deliveryMethodId, deliveryAddressId, orderNotes):
            return .requestParameters(parameters: ["id": 0, "paymentMethodId": paymentMethodId, "deliveryMethodId": deliveryMethodId, "deliveryAddressId": deliveryAddressId, "orderNotes": orderNotes], encoding: JSONEncoding.default)
        case let .addAddress(city, details, landmark):
            return .requestParameters(parameters: ["city": city, "addressDetails": details, "landmark": landmark], encoding: JSONEncoding.default)
        case let .updateAddress(id, city, details, landmark):
            return .requestParameters(parameters: ["id": id, "city": city, "addressDetails": details, "landmark": landmark], encoding: JSONEncoding.default)
        case let .deleteAddress(id):
            return .requestParameters(parameters: ["addressId": id], encoding: URLEncoding.queryString)
        case let .updateCart(cartId, productId, quantity):
            return .requestParameters(parameters: ["cart_id": cartId, "product_id": productId, "quantity": quantity], encoding: URLEncoding.queryString)
        case let .deleteFromCart(id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        case let .addToCart(productId, quantity):
            return .requestParameters(
                parameters: [
                    "product_id": productId,
                    "quantity": quantity
                ],
                encoding: URLEncoding.queryString
            )
        case let .register(fullName, phone, password):
            return .requestParameters(
                parameters: ["fullName": fullName, "phoneNumber": "992" + phone, "password": password],
                encoding: JSONEncoding.default
            )
        case let .login(phone, password):
            return .requestParameters(
                parameters: ["phoneNumber": "992" + phone, "password": password],
                encoding: JSONEncoding.default
            )
        case let .products(name, categoryId, subCategoryId, orderByPrice, pageSize, pageNumber):
            var parameters: [String: Any] = ["name": name, "categoryId": categoryId, "pageSize": pageSize, "pageNumber": pageNumber, "orderByPrice": orderByPrice]
            parameters["subCategoryId"] = subCategoryId
            return .requestParameters(
                parameters: parameters,
                encoding: JSONEncoding.default
            )
        case let .product(id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        case .categories, .me, .cart, .removeAccount:
            return .requestPlain
        case .subCategories(let categoryId):
            return .requestParameters(parameters: ["categoryId": categoryId], encoding: URLEncoding.queryString)
        case let .changeAvatar(imageData):
            let formData = MultipartFormData(provider: .data(imageData), name: "img", fileName: "image.png", mimeType: "image/png")
            return .uploadMultipart([formData])
        }
    }
    
    var headers: [String : String]? {
        ["Authorization": "Bearer \(KeychainManager.shared.token ?? "")"]
    }
    
    var validationType: ValidationType {
        .successAndRedirectCodes
    }
}
