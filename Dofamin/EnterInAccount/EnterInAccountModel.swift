//
//  EnterInAccountModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 02/01/25.
//

import Foundation
import Moya

struct EnterInAccountModel {
    struct Data {
        var number: String
        var password: String
        var button: String
        
        var isValid: Bool {
            number.count == 9 && password.count >= 6
        }
    }
    enum Route {
        case catalog
    }
    
    struct Error {
        var message: String?
        var isPresented: Bool
        
        init() {
            self.isPresented = false
            self.message = nil
        }
        
        init(error: MoyaError) {
            self.isPresented = true
            self.message = ErrorWrapper(error: error).message
        }
    }
}

