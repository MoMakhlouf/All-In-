//
//  LoginViewModel.swift
//  All-In
//
//  Created by Mahmoud Saad on 13/07/2022.
//

import Foundation
class LoginViewModel{
    
    let networking = NetworkManager()

    func checkUserIsLogged(email: String, password: String, completion: @escaping (Customr?)-> Void){
        networking.getAllCustomers { customers, error in
            guard let customers = customers, error == nil else {return}
            
            let filetr = customers.customers.filter { selectedCustomer in
                return selectedCustomer.email == email && selectedCustomer.tags == password
            }
            
            if filetr.count != 0{
                Helper.shared.setUserStatus(userIsLogged: true)
                guard let customerID = filetr[0].id, let userFirstName = filetr[0].first_name, let userLastName = filetr[0].lastName, let userEmail = filetr[0].email  else {return}
                Helper.shared.setUserID(customerID: customerID)
                Helper.shared.setUserName(userName: "\(userFirstName) \(userLastName)")
                Helper.shared.setUserEmail(userEmail: userEmail)
                if !filetr[0].addresses!.isEmpty {
                    Helper.shared.setFoundAdress(isFoundAddress: true)
                }
                completion(filetr[0])
            }else{
                completion(nil)
            }
        }
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    

