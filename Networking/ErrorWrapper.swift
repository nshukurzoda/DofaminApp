//
//  ErrorWrapper.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 23/01/25.
//

import Foundation
import Moya

struct ErrorResponse: Decodable {
    let message: String
}

struct ErrorWrapper {
    let message: String
    
    init(error: MoyaError) {
        do {
            switch error {
            case  .statusCode(let response), .jsonMapping(let response), .objectMapping(_, let response):
                let error = try response.map(ErrorResponse.self)
                self.message = error.message
            case .underlying(_, let response):
                let error = try response?.map(ErrorResponse.self)
                self.message = error?.message ?? "Произошла ошибка, повторите позже"
            default:
                self.message = "Произошла ошибка, повторите позже"
            }
        }
        catch {
            self.message = "Произошла ошибка, повторите позже"
        }
    }
}
