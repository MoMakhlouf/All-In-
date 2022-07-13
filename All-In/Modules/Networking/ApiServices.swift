//
//  ApiServices.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 02/07/2022.
//

import Foundation
import UIKit

protocol ApiServices {
    
    func getDiscountCode( priceRule : String , completion : @escaping ( ([Discount_codes]? , Error?) -> Void))
    
    func getAddress( customerId : String , completion : @escaping ( ([Address]? , Error?) -> Void))
    
    func postAddress(customerID : String  , address : Address , completion : @escaping(Data? , URLResponse? , Error?) ->())
    
    func deleteAddress(customerID : String  , addressID : Int , completion : @escaping(Error?) ->())
    
    func convertCurrency(amount : String , completion: @escaping ((Double?, Error?) -> Void))
    
    func fetchBrands(completion: @escaping (SmartCollections?  , Error?) -> Void)
    func fetchProducts(completion: @escaping (Products?  , Error?) -> Void)
    func fetchCollects(completion: @escaping (Collects?  , Error?) -> Void)
    func fetchCategories(completion: @escaping (CustomCollections?  , Error?) -> Void)
    

}
