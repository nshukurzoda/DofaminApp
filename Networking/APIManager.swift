//
//  APIManager.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 23/01/25.
//

import Foundation
import Combine
import Moya
import UIKit

final class APIManager {
    static let shared = APIManager()
    
    private let networking = Networking<API>.defaultNetworking()
    
    func register(fullName: String, phone: String, password: String) -> AnyPublisher<TokenResponse, MoyaError> {
        networking.requestObject(.register(fullName: fullName, phone: phone, password: password), type: TokenResponse.self)
    }
    
    func login(phoneNumber: String, password: String) -> AnyPublisher<TokenResponse, MoyaError> {
        networking.requestObject(.login(phoneNumber: phoneNumber, passwordHash: password), type: TokenResponse.self)
    }
    
    func getCategories() -> AnyPublisher<CategoriesResponse, MoyaError> {
        networking.requestObject(.categories, type: CategoriesResponse.self)
    }
    
    func getSubCategories(categoryId: Int) -> AnyPublisher<SubCategoriesResponse, MoyaError> {
        networking.requestObject(.subCategories(id: categoryId), type: SubCategoriesResponse.self)
    }
    
    func getCategoriesDetails(
        name: String,
        categoryId: Int,
        subCategoryId: Int?,
        orderByPrice: Int,
        pageNumber: Int,
        pageSize: Int
    ) -> AnyPublisher<ProductsResponse, MoyaError> {
        networking.requestObject(
            .products(
                name: name,
                categoryId: categoryId,
                subCategoryId: subCategoryId,
                orderByPrice: orderByPrice,
                pageSize: pageSize,
                pageNumber: pageNumber
            ),
            type: ProductsResponse.self
        )
    }
    
    func getProduct(id: Int) -> AnyPublisher<ProductResponse, MoyaError> {
        networking.requestObject(.product(id: id), type: ProductResponse.self)
    }
    
    func getMe() -> AnyPublisher<UserResponse, MoyaError> {
        networking.requestObject(.me, type: UserResponse.self)
    }
    
    func getOrders() -> AnyPublisher<[OrderResponse], MoyaError> {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 5 * 3600)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return networking.requestObject(.me, type: UserResponse.self, using: decoder)
            .map { userResponse in
                var orders = userResponse.orders
                for i in orders.indices {
                    var order = orders[i]
                    if order.deliveryAddress == nil {
                        order.deliveryAddress = userResponse.addresses.first(where: { order.deliveryAddressId == $0.id }) ?? .init(id: 0, landmark: "", city: "", details: "")
                    }
                    orders[i] = order
                }
                return orders
            }
            .eraseToAnyPublisher()
    }
    
    func addToCart(productId: Int, quantity: Int) -> AnyPublisher<AddToCartResponse, MoyaError> {
        networking.requestObject(.addToCart(productId: productId, quantity: quantity), type: AddToCartResponse.self)
    }
    
    func deleteFromCart(id: Int) -> AnyPublisher<Response, MoyaError> {
        networking.requestWithoutMapping(.deleteFromCart(id: id))
    }
    
    func updateCart(id: Int, productId: Int, quantity: Int) -> AnyPublisher<Response, MoyaError> {
        networking.requestWithoutMapping(.updateCart(cartId: id, productId: productId, quantity: quantity))
    }
    
    func getCart() -> AnyPublisher<CartResponse, MoyaError> {
        networking.requestObject(.cart, type: CartResponse.self)
    }
    
    func addAddress(city: String, details: String, landmark: String) -> AnyPublisher<AddressResponse, MoyaError> {
        networking.requestObject(.addAddress(city: city, details: details, landmark: landmark), type: AddressResponse.self)
    }
    
    func updateAddress(id: Int, city: String, details: String, landmark: String) -> AnyPublisher<AddressResponse, MoyaError> {
        networking.requestObject(.updateAddress(id: id, city: city, details: details, landmark: landmark), type: AddressResponse.self)
    }
    
    func deleteAddress(id: Int) -> AnyPublisher<Response, MoyaError> {
        networking.requestWithoutMapping(.deleteAddress(id: id))
    }
    
    func orderProduct(paymentMethodId: Int = 1, deliveryMethodId: Int, deliveryAddressId: Int, orderNotes: String) -> AnyPublisher<Response, MoyaError> {
        networking.requestWithoutMapping(.orderProduct(paymentMethodId: paymentMethodId, deliveryMethodId: deliveryMethodId, deliveryAddressId: deliveryAddressId, orderNotes: orderNotes))
    }
    
    func updateProfile(name: String, phoneNumber: String, password: String) -> AnyPublisher<UserResponse, MoyaError> {
        networking.requestObject(.updateProfile(name: name, phoneNumber: phoneNumber, password: password), type: UserResponse.self)
    }
    
    func changeAvatar(imageData: Data) -> AnyPublisher<AvatarResponse, MoyaError> {
        networking.requestObject(.changeAvatar(imageData: imageData), type: AvatarResponse.self)
    }
    
    func removeAccount() -> AnyPublisher<Response, MoyaError> {
        networking.requestWithoutMapping(.removeAccount)
    }
}
