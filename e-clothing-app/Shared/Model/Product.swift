//
//  Product.swift
//  e-clothing-app
//
//  Created by Yesh Adithya on 2024-03-28.
//

import Foundation

struct Product: Identifiable, Hashable, Encodable, Decodable {
    let id: String
    var title: String
    let description: String
    let category: String
    let image: String
    let price: Double
    let ratingCount: Int
    let ratingRate: Double
    var quantity: Int
}
