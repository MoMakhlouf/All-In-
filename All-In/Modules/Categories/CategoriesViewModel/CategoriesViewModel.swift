//
//  CategoriesViewModel.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import Foundation

class CategoriesViewModel{
    
    var collectsArray: Collects?{
        didSet{
            bindingData(collectsArray, nil)
        }
    }
    var error: Error?{
        didSet{
            bindingData(nil, error)
            
        }
    }
    let apiService: ApiServices
    var bindingData: ((Collects?, Error?)-> Void) = {_ , _ in}
    init(apiService: ApiServices = NetworkManager()){
        self.apiService = apiService
    }
    func fetchCollects(){
        
        apiService.fetchCollects { collects, error in
            if let collects = collects {
                self.collectsArray = collects
            }
            if let error = error {
                self.error = error
            }
        }
        
    }
    
}
