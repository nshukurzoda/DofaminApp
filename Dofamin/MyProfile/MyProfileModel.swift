//
//  MyProfileModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 14/12/24.
//

import Foundation

struct MyProfileModel {
    struct Profile {
        var name: String
        var number: String
        
        var isLoading = false
        
        var isAvailable: Bool {
            !name.isEmpty && number.count == 9 
        }
        
        init(user: User) {
            self.name = user.fullName
            self.number = String(user.phoneNumber.dropFirst(3))
        }
    }
}
