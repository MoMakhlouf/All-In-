//
//  discountCodeModel.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 03/07/2022.
//

import Foundation

//struct DiscountCodeModel: Codable {
//    let discountCodes: [DiscountCodeElement]
//
//}
//
//// MARK: - DiscountCodeElement
//struct DiscountCodeElement: Codable {
//    let id, priceRuleID: Int
//    let code: String
//    let usageCount: Int
//    let createdAt, updatedAt: Date
////
////    enum CodingKeys: String, CodingKey {
////        case id
////        case priceRuleID = "price_rule_id"
////        case code
////        case usageCount = "usage_count"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
////    }
//}

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













