//
//  NetworkManagerMock.swift
//  All-InTests
//
//  Created by Mohamed Makhlouf Ahmed on 05/07/2022.
//

import Foundation
 @testable import All_In

class NetworkManagerMock : NetworkManager{
    
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool){
        self.shouldReturnError = shouldReturnError
    }
    
    
    let jsonResponseCoupon : [String: [[String : Any]]] =
    ["discount_codes":
        [["id":15662475641046,"price_rule_id":1191661535446,"code":"SUMMERSALE50FF","usage_count":0,"created_at":"2022-07-01T02:14:01+02:00","updated_at":"2022-07-01T02:14:01+02:00"],["id":15662472560854,"price_rule_id":1191661535446,"code":"SUMMERSALE10OFF","usage_count":0,"created_at":"2022-07-01T02:08:12+02:00","updated_at":"2022-07-01T02:08:12+02:00"]
        ]
    ]
    
    
    
    func fetchCodes(completion : @escaping (([Discount_codes]? , Error?) -> Void)){
        
        switch shouldReturnError {
        case true : completion(nil , NetworkError.failedFetchingData)
        
        case false :
            if let data = try? JSONSerialization.data(withJSONObject: jsonResponseCoupon, options: .fragmentsAllowed) {
                   if let decodedData = try? JSONDecoder().decode(DiscountCode.self, from: data){
                       completion(decodedData.discount_codes , nil)
                      
                   }else{
                       completion(nil, NetworkError.failedFetchingData)
                     
                   }
                   }
            else {
               completion(nil, NetworkError.failedFetchingData)
               
            }
            
        }
        
        
    }
    
    
}

enum NetworkError: Error {
    case failedFetchingData
}
