//
//  TokenResponse.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 31/01/25.
//

import Foundation

struct TokenResponse: Decodable {
    let token: String
    let refreshToken: String
}
