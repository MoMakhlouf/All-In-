//
//  Urls.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 02/07/2022.
//

import Foundation

struct Urls {
    
    var priceRule = ""
    var customerId = 0
    var addressId = 0
    var amount = ""

    var baseUrl  : String {
        
        return "https://7d67dd63dc90e18fce08d1f7746e9f41:shpat_8e5e99a392f4a8e210bd6c4261b93 50e@ios-q3-mansoura.myshopify.com/admin/api/2022-01/"

    }
    var discountCodeUrl  : String {
        return
         "https://7d67dd63dc90e18fce08d1f7746e9f41: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@ios-q3-mansoura.myshopify.com/admin/api/2022-04/price_rules/\(priceRule)/discount_codes.json"
    }
    
    var addressUrl : String {
        return "https://ios-q3-mansoura.myshopify.com/admin/api/2022-04/customers/\(customerId)/addresses.json"
    }
    
    var postAddressUrl : String {
        return "https://ios-q3-mansoura.myshopify.com/admin/api/2022-04/customers/\(customerId)/addresses.json"
    }
    
    var deleteAddressUrl : String {
        return "https://ios-q3-mansoura.myshopify.com/admin/api/2022-04/customers/\(customerId)/addresses/\(addressId).json"
    }

    
    var currencyUrl : String {
        return "https://api.apilayer.com/currency_data/convert?to=EGP&from=USD&amount=\(amount)"
    }
        

}

    //MARK: - Mahmoud
struct URLs{
    static let shared = URLs()
    
     
    let baseURL =
    
        "https://7d67dd63dc90e18fce08d1f7746e9f41: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@ios-q3-mansoura.myshopify.com/admin/api/2022-01/"

   
    func customersURl()-> URL?{
        return URL(string: baseURL + "customers.json")
}
}

