//
//  CurrencyViewModel.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 13/07/2022.
//

import Foundation

class CurrencyViewModel {
    
    var result : Double? {
        didSet{
            bindingData(result , nil)
        }
    }
  
    
    var error : Error?{
        didSet{
            bindingData(nil , error)
        }
    }
    
    
 
    var bindingData : ((Double? , Error?) -> Void) = {_,_ in}
    let apiService : ApiServices
    init(apiServices : ApiServices = NetworkManager()){
        self.apiService = apiServices
    }


     func convertCurrency(amount : String){
         apiService.convertCurrency(amount: amount) { result, error in
             
             if let result = result {
                 self.result = result
                 print(result)
                 print("get result")
             }
             if let error = error {
                 print("error \(error)")
             }
         }
         
        }
}
