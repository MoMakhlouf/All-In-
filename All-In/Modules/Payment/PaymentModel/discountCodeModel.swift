//
//  discountCodeModel.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 03/07/2022.
//

import Foundation

struct DiscountCode: Codable {
    let discount_codes: [Discount_codes]?
}

struct Discount_codes: Codable {
    let id, price_rule_id: Int
    let code: String
    let usage_count: Int
    let created_at, updated_at: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case price_rule_id = "price_rule_id"
        case code = "code"
        case usage_count = "usage_count"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
}













