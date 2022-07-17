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
    var currency: String
    var current_subtotal_price: String
    var current_total_price: String
    var created_at: String
    var line_items: [Items]
   // var billing_address: Address
}


struct Items: Codable{
    var title: String
    var price: String
    var quantity: Int
    var sku: String
}
