//
//  CategoriesModel.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import Foundation

// MARK: - Collects
struct Collects: Codable {
    var collects: [Collect]
}

// MARK: - Collect
struct Collect: Codable {
    var id: Int
    var collection_id: Int
    var product_id: Int
  //  var created_at, updated_at: Date
    var position: Int
    var sort_value: String
}

// MARK: - CustomCollections
struct CustomCollections: Codable {
    var custom_collections: [CustomCollection]

}

// MARK: - CustomCollection
struct CustomCollection: Codable {
    var id: Int
    var handle: String
    var title: String
 //   var updated_at: Date
    var body_html: String?
//    var published_at: Date
    var sort_order: String
    var published_scope: String
    var admin_graphql_api_id: String
    var image: Imagees?

}

// MARK: - Image
struct Imagees: Codable {
//    var createdAt: Date
  //  var width: Int
  //  var height: Int
    var src: String

}

