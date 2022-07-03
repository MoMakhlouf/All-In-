//
//  HomeModel.swift
//  All-In
//
//  Created by Marwa on 01/07/2022.
//

import Foundation

// MARK: - Collects
struct Collects: Codable {
    var smartCollections: [SmartCollection]
}

// MARK: - SmartCollection
struct SmartCollection: Codable {

    var handle: String
    var title: String
    var image: Image

}

// MARK: - Image
struct Image: Codable {
    var src: String
}

