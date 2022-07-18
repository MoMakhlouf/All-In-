//
//  Defaults.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 13/07/2022.
//

import Foundation


class Defaults {
    static let defaults = Defaults()
    
    private init(){

    }
    
    func setCurrency(key : String , value : String){
        UserDefaults.standard.set(value, forKey: key)
        print("in Set Currency")

    }
    
    func getCurrency(key : String = "currency") -> String{
        let currency = UserDefaults.standard.string(forKey: key)
        if  currency == "" {
            return "USD"
        }
        return currency ?? ""
    }
    
    
    //MARK: -   currency
     // set from home amount of 1 dollar in egp
    func setUsdValue(value : String , key : String){
        UserDefaults.standard.set(value, forKey: key )
        print("usd")
    }
    
    func getUsdValue(key : String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    
    }
    
    //MARK: -  set Address from list of address "did select" to label in checkout payment
 
    func setAddress(value : String , key : String){
        UserDefaults.standard.set(value, forKey: key )
       
    }
    
    func getAddress(key : String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    
    }
}


