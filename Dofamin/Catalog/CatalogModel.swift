//
//  CatalogModel.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 09/12/24.
//

import Foundation
import SwiftUI
import Moya

struct CatalogModel {
    struct Catalog: Identifiable {
        let id: Int
        let name: String
        let productCount: Int
        let imageUrl: URL?
        
        init(response: CategoryResponse) {
            self.name = response.name
            self.id = response.id
            self.productCount = response.productCount
            self.imageUrl = response.imageUrl
        }
    }
    
    enum Route {
      case product(Catalog)
    }
}
