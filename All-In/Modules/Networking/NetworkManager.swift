//
//  NetworkManager.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 02/07/2022.
//

import Foundation

class NetworkManager : ApiServices{
    
  static let shared = NetworkManager()
  
    
    
    
    
//MARK: - Mohamed - Post Address
    
    func postAddress(customerID: String, address: Address, completion: @escaping (Date?, URLResponse?, Error?) -> ()) {
        
        
        if let url = URL(string: Urls(customerId: customerID).postAddressUrl){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpShouldHandleCookies = false
            if let httpBody = try? JSONSerialization.data(withJSONObject: address, options: []) {
                
                request.httpBody = httpBody
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        print(json)
                        print("post")
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    //MARK: - Mohamed - Get Address
    func getAddress(customerId: String, completion: @escaping (([Address]?, Error?) -> Void)) {
        if let url = URL(string: Urls(customerId: customerId).addressUrl){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data{
                    if let decodedData = try? JSONDecoder().decode(Customer.self, from: data){
                        completion(decodedData.addresses , nil)
                        print("123\(decodedData.addresses)")
                    }
                 }
            }
            task.resume()
        }
    }
    
    
    
    //MARK: - Mohamed - Delete Address
    
    func deleteAddress(customerID: String, addressID: Int, completion: @escaping (Error?) -> ()) {
        
        if let url = URL(string: Urls(customerId: customerID , addressId: addressID).deleteAddressUrl){
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(error)
                        return
                    }
                completion(nil)
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
                     print(decodedData.discount_codes)
                }
            }
        }
            task.resume()
        }
    }
   // 1191661535446
}


//
//extension Encodable {
//    func asDictionary() throws -> [String: Any] {
//        let data = try JSONEncoder().encode(self)
//        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
//            throw NSError()
//        }
//        return dictionary
//    }
//}
