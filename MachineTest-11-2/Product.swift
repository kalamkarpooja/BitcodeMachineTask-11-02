//
//  Product.swift
//  MachineTest-11-2
//
//  Created by Mac on 06/03/23.
//

import Foundation
struct Data: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
