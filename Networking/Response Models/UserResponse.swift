//
//  UserResponse.swift
//  Dofamin
//
//  Created by Ботурбек Имомдодов on 03/02/25.
//

import Foundation

struct UserResponse: Decodable {
    let id: Int
    let imageUrl: String?
    let fullName: String
    let phoneNumber: String
    let addresses: [AddressResponse]
    let orders: [OrderResponse]
}

