//
//  discountCodeViewModel.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 03/07/2022.
//

import Foundation

class DiscountCodeViewModel {
    
var discountCodesArray : [Discount_codes]?{
    didSet{
        bindingData(discountCodesArray , nil)
    }
}

var error : Error?{
    didSet{
        bindingData(nil , error)
    }
}

var bindingData : (([Discount_codes]? , Error?) -> Void) = {_ , _ in}
let apiService : ApiServices
    
init(apiServices : ApiServices = NetworkManager()){
    self.apiService = apiServices
}
    
    func getDiscountCode(){
        apiService.getDiscountCode(priceRule: "1191661535446") { discountCodes, error in
            if let discountCodes = discountCodes {
                self.discountCodesArray = discountCodes
                print("getDiscountCodeFunction")
            }
            if let error = error {
                DispatchQueue.main.async {
                    //Alert.displayAlert(title: "", message: <#T##String#>)
                }
            self.error = error
            }
            
        }
   
}
}

