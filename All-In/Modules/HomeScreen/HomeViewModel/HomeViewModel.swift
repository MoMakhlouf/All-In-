//
//  HomeViewModel.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import Foundation
import CoreVideo

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

