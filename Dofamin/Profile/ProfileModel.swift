//
//  ProfileModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 14/12/24.
//

import Foundation
import SwiftUI

struct ProfileModel {
    struct Profile {
        static let empty = Profile(name: "Не идентифицирован", number: "")
        
        let name: String
        let number: String
        var avatar: String?
        
        init(name: String, number: String) {
            self.name = name
            self.number = number
            self.avatar = nil
        }
        
        init(user: User) {
            self.name = user.fullName
            self.number = user.phoneNumber
            self.avatar = user.avatar
        }
    }
    
    enum Setting: CaseIterable {
        case profile
        case orders
        case addresses
        
        var route: Route {
            switch self {
            case .profile:
                    .myProfile
            case .orders:
                    .myOrders
            case .addresses:
                    .myAddresses
            }
        }
        
        func title(for strings: Strings) -> String {
            switch self {
            case .profile:
                strings.profileMyProfile
            case .orders:
                strings.profileOrders
            case .addresses:
                strings.profileAddresses
            }
        }
        
        var icon: Image {
            switch self {
            case .profile:
                Image(.setting)
            case .orders:
                Image(.bag)
            case .addresses:
                Image(.map)
            }
        }
    }
    
    enum Route {
        case myAddresses
        case myOrders
        case myProfile
    }
}

