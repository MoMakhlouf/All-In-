//
//  HomeViewModel.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import Foundation
import CoreVideo

protocol ApiServices{
    func fetchBrands(completion: @escaping (SmartCollections?  , Error?) -> Void)
    func fetchProducts(completion: @escaping (Products?  , Error?) -> Void)
    func fetchCollects(completion: @escaping (Collects?  , Error?) -> Void)
    func fetchCategories(completion: @escaping (CustomCollections?  , Error?) -> Void)
    
}


class NetworkManager: ApiServices{
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
  //  https://ios-q3-mansoura.myshopify.com/admin/api/2022-01/smart_collections.json?7d67dd63dc90e18fce08d1f7746e9f41-Shopfiy-access_token=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
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

}

class HomeViewModel{
    
    var brandsArray: SmartCollections?{
        didSet{
            bindingData(brandsArray, nil)
        }
    }
    var error: Error?{
        didSet{
            bindingData(nil , error)
            
        }
    }
    
    let apiService : ApiServices
    var bindingData: ((SmartCollections? , Error?) -> Void) = {_ , _ in}
    init(apiService :ApiServices = NetworkManager()){
        self.apiService = apiService
    }
    func fetchData(){
        apiService.fetchBrands { brands, error in
            if let brands = brands {
                self.brandsArray = brands
            }
            
            if let error = error {
                self.error = error
            }
        }
    }
   
}
