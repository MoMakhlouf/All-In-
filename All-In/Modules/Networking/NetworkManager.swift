//
//  NetworkManager.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 02/07/2022.
//

import Foundation

class NetworkManager : ApiServices{
    
    
    
  
    
    
    
    //MARK: - Mohamed - Get Address
    func getAddress(customerId: String, completion: @escaping (([Address]?, Error?) -> Void)) {
        if let url = URL(string: Urls(customerId: customerId).addressUrl){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data{
                    if let decodedData = try? JSONDecoder().decode(Customer.self, from: data){
                        completion(decodedData.addresses , nil)
                        print(decodedData.addresses)
                    }

                 }
            }
            task.resume()
        }
    }
    
    
    
    //MARK: - Mohamed - Get discount Code
    func getDiscountCode( priceRule : String , completion: @escaping (([Discount_codes]?, Error?) -> Void)) {
        
        if let url = URL(string: Urls(priceRule: priceRule).discountCodeUrl){
            let task = URLSession.shared.dataTask(with: url){data, response, error in
                print(url)
                if let data = data {
                    if let decodedData = try? JSONDecoder().decode(DiscountCode.self, from: data){
                        completion(decodedData.discount_codes , nil)
                     print("123\(decodedData.discount_codes)")
                }
            }
        }
            task.resume()
        }
    }
   // 1191661535446
}
    

    
    

