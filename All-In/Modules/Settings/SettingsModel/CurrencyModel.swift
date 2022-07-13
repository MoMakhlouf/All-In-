//
//  CurrencyModel.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 13/07/2022.
//

import Foundation
struct Currency: Codable {
    let date: String
    let info: Info
    let query: Query
    let result: Double
    let success: Bool
}

// MARK: - Info
struct Info: Codable {
    let quote: Double
    let timestamp: Int
}

// MARK: - Query
struct Query: Codable {
    let amount: Int
    let from, to: String
}
