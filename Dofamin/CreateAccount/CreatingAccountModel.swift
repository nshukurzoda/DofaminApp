//
//  CreatingAccountModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 02/01/25.
//

import Foundation
import Moya

struct CreatingAccountModel {
    struct AccountData {
        var name: String
        var phoneNumber: String
        var password: String
        
        var isValid: Bool {
            name.count > 3 && phoneNumber.count == 9 && password.count >= 6
        }
    }
    
    struct Error {
        let message: String
        var isPresented: Bool
        
        init() {
            self.isPresented = false
            self.message = ""
        }
        
        init(error: MoyaError) {
            self.isPresented = true
            self.message = ErrorWrapper(error: error).message
        }
    }
}
