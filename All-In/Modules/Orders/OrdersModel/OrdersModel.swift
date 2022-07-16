//
//  OrdersModel.swift
//  All-In
//
//  Created by Marwa on 14/07/2022.
//

import Foundation

struct Orders: Codable{
    var orders: [Order]
    
}
struct Order: Codable{
    var id: Int
    var product_id: Int
    var contact_email: String
    var currency: String
    var current_subtotal_price: String
    var current_total_price: String
    var email: String
    var order_number: Int
    var created_at: String
  //  var order_status_url: String
   // var token: String
  //  var customer: Customer
    var line_items: [Items]
    var billing_address: Address
}
//struct Customer: Codable{
    
//}


struct Items: Codable{
    var id: Int
    var title: String
    var price: String
    var quantity: Int
    var sku: String
}
