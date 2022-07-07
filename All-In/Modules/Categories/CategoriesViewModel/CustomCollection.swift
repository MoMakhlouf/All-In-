//
//  CustomCollection.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import Foundation
class CustomCollectionViewModel{
    var customCollectionArray: CustomCollections?{
        didSet{
            bindingData2(customCollectionArray, nil)
        }
    }
    var error: Error?{
        didSet{
            bindingData2(nil, error)
        }
    }
    
    var bindingData2: ((CustomCollections?, Error? ) -> Void) = {_, _ in}
    let apiService: ApiServices
    init(apiService: ApiServices = NetworkManager()){
        self.apiService = apiService
    }
    
    func fetchData(){
        apiService.fetchCategories { categories, error in
            
            if let categories = categories {
                self.customCollectionArray = categories
            }
            if let error = error {
                self.error = error
            }
        }
        
    }
    
}
