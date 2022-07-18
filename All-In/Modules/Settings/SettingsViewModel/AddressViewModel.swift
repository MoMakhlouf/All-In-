//
//  AddressViewModel.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 04/07/2022.
//

import Foundation

class AddressViewModel{
    
    var addressArray : [Address]?{
        didSet{
            bindingData(addressArray , nil)
        }
    }
     
    
    var error : Error?{
        didSet{
            bindingData(nil , error)
        }
    }
    
    
    var bindingData : (([Address]? , Error?) -> Void) = {_,_ in}
    let apiService : ApiServices
    init(apiServices : ApiServices = NetworkManager()){
        self.apiService = apiServices
    }
    
    
    func getAdderss(customerId : Int){
        apiService.getAddress(customerId: customerId) { addresses, error in
            if let addresses = addresses {
                self.addressArray = addresses
                print("get address")
            }
            if let error = error {
                print("errorr")
                DispatchQueue.main.async {
                    Alert.displayAlert(title: "Error in Address", message: "Write a right address")
                }
                self.error = error
            }
        }
    }
    
}
