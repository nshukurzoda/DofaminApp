//
//  CategortyDetailsResponses.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 31/01/25.
//

import Foundation

struct CategoriesDetailsResponses: Decodable {
    let categoryID: Int
    let pageNumber:Int
    let pageSize: Int
}
