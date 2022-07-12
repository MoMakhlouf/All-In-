//
//  Decoder.swift
//  All-In
//
//  Created by Mahmoud Saad on 11/07/2022.
//

import Foundation
func convertFromJson<T:Codable>(data:Data) -> T? {
    
    let decoder = JSONDecoder()
    let decodedData = try? decoder.decode(T.self, from: data)
    
    return decodedData

}
