//
//  OrdersModel.swift
//  All-In
//
//  Created by Marwa on 14/07/2022.
//

import Foundation
//
//struct Orders: Codable{
//    var orders: [Order]
//
//}
//struct Order: Codable{
//    var id: Int
//  //  var contact_email: String
//    var currency: String
//    var current_subtotal_price: String
//    var current_total_price: String
//   // var email: String
//   // var order_number: Int
//    var created_at: String
//  //  var order_status_url: String
//   // var token: String
//  //  var customer: Customer
//    var line_items: [Items]
//    var billing_address: Address
//}
////struct Customer: Codable{
//
////}
//
//
//struct Items: Codable{
//    //var id: Int
//    var title: String
//    var price: String
//    var quantity: Int
//  //  var variant_id: Int
//    var sku: String
//}


//
//// MARK: - CustomCollections
//struct CustomCollectionss: Codable {
//    var orders: [Orderr]
//}
//
//// MARK: - Order
//struct Orderr: Codable {
//    var lineItems: [LineItem]
//    var email, phone: String
//    var billingAddress, shippingAddress: IngAddress
//    var transactions: [Transaction]
//    var financialStatus: String
//    var discountCodes: [DiscountCode]
//
//    enum CodingKeys: String, CodingKey {
//        case lineItems
//        case email, phone
//        case billingAddress
//        case shippingAddress
//        case transactions
//        case financialStatus
//        case discountCodes
//    }
//}
//
//// MARK: - IngAddress
//struct IngAddress: Codable {
//    var firstName, lastName, address1, phone: String
//    var city, province, country, zip: String
//
//    enum CodingKeys: String, CodingKey {
//        case firstName
//        case lastName
//        case address1, phone, city, province, country, zip
//    }
//}
//
//// MARK: - DiscountCode
//struct DiscountCode: Codable {
//    var code, amount, type: String
//}
//
//// MARK: - LineItem
//struct LineItem: Codable {
//    var variantID, quantity: Int
//
//    enum CodingKeys: String, CodingKey {
//        case variantID
//        case quantity
//    }
//}
//
//// MARK: - Transaction
//struct Transaction: Codable {
//    var kind, status: String
//    var amount: Int
//}



struct Orders: Codable{
    var orders: [Order]
    
}
struct Order: Codable{
    var id: Int
    var currency: String
    var current_subtotal_price: String
    var current_total_price: String
    var created_at: String
    var line_items: [Items]
    var billing_address: Address
}


struct Items: Codable{
    var title: String
    var price: String
    var quantity: Int
    var sku: String
}


