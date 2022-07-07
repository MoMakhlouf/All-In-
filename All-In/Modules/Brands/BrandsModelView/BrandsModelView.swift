//
//  BrandsModelView.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import Foundation
import CoreVideo
class BrandsViewModel{
    
    var productsArray: Products?{
        didSet{
            bindingData(productsArray, nil)
        }
    }
    var error: Error?{
        didSet{
            bindingData(nil , error)
            
        }
    }
    
    let apiService : ApiServices
    var bindingData: ((Products? , Error?) -> Void) = {_ , _ in}
    init(apiService :ApiServices = NetworkManager()){
        self.apiService = apiService
    }
    func fetchData(){
        apiService.fetchProducts{ products, error in
            if let products = products {
                self.productsArray = products
            }
            
            if let error = error {
                self.error = error
            }
        }
    }
   
}
