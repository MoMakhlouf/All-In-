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
    
    
    func getAdderss(customerId : String){
        apiService.getAddress(customerId: customerId) { addresses, error in
            if let addresses = addresses {
                self.addressArray = addresses
                print("gitadresssss")
            }
            if let error = error {
                print("errrrrrorrrr")
                self.error = error
            }
        }
    }
    
}
