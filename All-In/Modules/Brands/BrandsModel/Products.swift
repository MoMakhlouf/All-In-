//
//  Products.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import Foundation

// MARK: - Products

struct Products: Codable{
    var products: [Product]
}

// MARK: - Product
struct Product: Codable{
    var id: Int
    var title: String
    var body_html: String
    var vendor: String
    var product_type: String
    var handle: String
    var status: String
    var variants: [Variants]
    var options: [Option]
    var images: [Image]
    var image: Image
    
}

// MARK: - Variant
struct Variants: Codable{
    var id: Int
    var product_id: Int
    var title: String
    var price: String
    var sku: String
    var option1: String
    var option2: String
    var inventory_item_id: Int
    var inventory_quantity: Int
    var old_inventory_quantity: Int
    
}

// MARK: - Image
struct Images: Codable {
    var id: Int
    var productID: Int
    var position: Int
    //var createdAt, updatedAt: Date
  //  var width, height: Int
    var src: String
}

// MARK: - Option
struct Option: Codable {
    var id: Int
  //  var productID: Int
    var name: String
    var position: Int
    var values: [String]
}






