//
//  NetworkManager.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 02/07/2022.
//

import Foundation
import Alamofire

class NetworkManager : ApiServices{
   
 
  
    
    
    
  static let shared = NetworkManager()
    
    
  //  func getOrder(completion: @escaping (Orders?, Error?) -> ()) {
        
//        if let url = URL(string: "https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/customers/6278043893974/orders.json?access_token=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"){
//           URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data{
//                    let decodJson = JSONDecoder()
//                    let decodedArray = try? decodJson.decode(Orders.self, from: data)
//                        completion(decodedArray , nil)
//                    print("network manager")
//                    }
//                if let error = error {
//                    completion(nil,error)
//                    print("errorrrrrrr")
//                }
//           }.resume()
//        }
//
//    }
//
    func postOrder(customerID: Int, line_items: [Items], completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let url = URL(string: Urls().ordersUrl){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpShouldHandleCookies = false
            if let httpBody = try? JSONSerialization.data(withJSONObject: line_items, options: []) {
                
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
    
    

    
    func getOrder(customerID: Int, completion: @escaping (Orders?, Error?) -> ()) {
        if let url = URL(string: Urls(customerId1: customerID).customerOrdersUrl){
           URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data{
                    let decodJson = JSONDecoder()
                    let decodedArray = try? decodJson.decode(Orders.self, from: data)
                        completion(decodedArray , nil)
                    }
                if let error = error {
                    completion(nil,error)
                }
           }.resume()
        }
    }
    
    
    func fetchCategories(completion: @escaping (CustomCollections?, Error?) -> Void) {
        if let url = URL(string: "https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/custom_collections.json?access_token=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"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data{
                    let decodJson = JSONDecoder()
                    let decodedArray = try? decodJson.decode(CustomCollections.self, from: data)
                    completion(decodedArray, nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
    func fetchCollects(completion: @escaping (Collects?, Error?) -> Void) {
        if let url = URL(string: "https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/collects.json?access_token=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"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data{
                    let decodJson = JSONDecoder()
                    let decodedArray = try? decodJson.decode(Collects.self, from: data)
                    completion(decodedArray, nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
    func fetchProducts(completion: @escaping (Products?, Error?) -> Void) {
        if let url = URL(string:"https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/products.json?access_token=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"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decodJson = JSONDecoder()
                    let decodedArray = try? decodJson.decode(Products.self, from: data)
                   // let decodedArray: SmartCollections = convertFromJson(data: data)!
                    completion(decodedArray,nil)
                }
                if let error = error {
                    completion(nil,error)
                }
            }.resume()
        }
    }

 
    func fetchBrands(completion: @escaping (SmartCollections?, Error?) -> Void) {
        if let url = URL(string:"https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/smart_collections.json?access_token=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"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decodJson = JSONDecoder()
                    let decodedArray = try? decodJson.decode(SmartCollections.self, from: data)
                    //print(decodedArray?.smart_collections)
                   // let decodedArray: SmartCollections = convertFromJson(data: data)!
                    completion(decodedArray,nil)
                   
                }
                if let error = error {
                    completion(nil,error)
                }
            }.resume()
        }
    }


//MARK: - Mohamed - Post Address
    
    func postAddress(customerID: String, address: Address, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        
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
}
   // 1191661535446
    
    //MARK: - Mohamed - Currency
    func convertCurrency(amount: String , completion: @escaping ((Double?, Error?) -> Void)) {
  //  var semaphore = DispatchSemaphore (value: 0)
        if let url = URL(string: Urls(amount : amount).currencyUrl){
               
    var request = URLRequest(url: url ,timeoutInterval: Double.infinity)
      request.httpMethod = "GET"
      request.addValue("y74r6BOlgKDOoaMtz714xQRukKvUL2jF", forHTTPHeaderField: "apikey")
            //lQuu3oLhBMK9uv03G57xXqzVcuGCChaa
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
       // if let data = data {
            
         //   let jsonData =  String(data: data , encoding: .utf8)!
          //  print("111 \(jsonData.result)")
            
//            if let decodedData = try? JSONDecoder().decode(Currency.self, from: jsonData.data(using: .utf8)!){
//                completion(decodedData.result , nil)
//                print("www \(decodedData.result) w1234")
//            }
            
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])

                    // if let decodedData = try? JSONDecoder().decode(Currency.self, from: json as! Data){
                      //  completion(decodedData.result , nil)
                        //          print("www \(decodedData.result) w1234")
                             // }
                    
                    print(json)
                    print("qwe")
                }catch {
                    print(error.localizedDescription)
                }
            
            
            print(String(data: data , encoding: .utf8)!)

          //  semaphore.signal()
           }
       }
              task.resume()
            //  semaphore.wait()
   }
}

    
    //MARK: - Mahmoud Register
    
    
    extension NetworkManager{
        
        func register(newCustomer:NewCustomr, completion:@escaping (Data?, URLResponse? , Error?)->()){
            guard let url = URLs.shared.customersURl() else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let session = URLSession.shared
            request.httpShouldHandleCookies = false
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
                print(try! newCustomer.asDictionary())
            } catch let error {
                print(error.localizedDescription)
            }
            
            //HTTP Headers
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            session.dataTask(with: request) { (data, response, error) in
                completion(data, response, error)
            }.resume()
        }
    }

extension NetworkManager{
    func getAllCustomers(complition: @escaping (AllCustomers?, Error?)->Void){
        guard let url = URLs.shared.customersURl() else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                print("error")
                complition(nil, error)
            case .success(_):
                guard let data = res.data else { return }
                do{
                    let json = try JSONDecoder().decode(AllCustomers.self, from: data)
                    complition(json, nil)
                    print("success to get customers")
                }catch let error{
                    print("error when get customers")
                    complition(nil, error)
                }
            }
        }
    }
 

}
 
