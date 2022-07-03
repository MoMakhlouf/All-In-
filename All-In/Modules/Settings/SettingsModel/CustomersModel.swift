//
//  CustomersModel.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 03/07/2022.
//

import Foundation

struct CustomerModel: Codable {
    let customers: [Customer]
}

// MARK: - Customer
struct Customer: Codable {
    let id: Int
    let email: String
    let acceptsMarketing: Bool
    let createdAt, updatedAt: Date
    let firstName, lastName: String
    let ordersCount: Int
    let totalSpent: String
    let lastOrderID: Int?
    let taxExempt: Bool
    let phone: String?
    let tags: String
    let lastOrderName: String?
    let currency: Currency
    let addresses: [Address]
    let acceptsMarketingUpdatedAt: Date
    let adminGraphqlAPIID: String
    let defaultAddress: Address?

//    enum CodingKeys: String, CodingKey {
//        case id, email
//        case acceptsMarketing = "accepts_marketing"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case ordersCount = "orders_count"
//        case state
//        case totalSpent = "total_spent"
//        case lastOrderID = "last_order_id"
//        case note
//        case verifiedEmail = "verified_email"
//        case multipassIdentifier = "multipass_identifier"
//        case taxExempt = "tax_exempt"
//        case phone, tags
//        case lastOrderName = "last_order_name"
//        case currency, addresses
//        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
//        case marketingOptInLevel = "marketing_opt_in_level"
//        case taxExemptions = "tax_exemptions"
//        case smsMarketingConsent = "sms_marketing_consent"
//        case adminGraphqlAPIID = "admin_graphql_api_id"
//        case defaultAddress = "default_address"
//    }
}

// MARK: - Address
struct Address: Codable {
    let id, customerID: Int
    let firstName, lastName: String
    let address1: String
    let city, province, country, zip: String
    let phone, name: String
    let provinceCode: String?
    let countryCode, countryName: String
    let addressDefault: Bool

//    enum CodingKeys: String, CodingKey {
//        case id
//        case customerID = "customer_id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case company, address1, address2, city, province, country, zip, phone, name
//        case provinceCode = "province_code"
//        case countryCode = "country_code"
//        case countryName = "country_name"
//        case addressDefault = "default"
//    }
}

enum Currency: String, Codable {
    case egp = "EGP"
}
