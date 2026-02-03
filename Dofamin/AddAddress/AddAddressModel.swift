//
//  AddAddressModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 26/12/24.
//

import Foundation
struct AddAddressModel {
    struct Address {
        var id: Int?
        var city: String
        var details: String
        var landmark: String
        
        var isLoading = false
        
        var isAdded: Bool {
            id != nil
        }
        
        var isAvailable: Bool {
            city.count > 0 && details.count > 0
        }
        
        init(id: Int? = nil, city: String, details: String, landmark: String) {
            self.id = id
            self.city = city
            self.details = details
            self.landmark = landmark
        }
        
        init(response: AddressResponse) {
            self.id = response.id
            self.city = response.city
            self.details = response.details
            self.landmark = response.landmark
        }
    }
}
