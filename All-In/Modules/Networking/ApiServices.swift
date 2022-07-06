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
    
    func postAddress(customerID : String  , address : Address , completion : @escaping(Date? , URLResponse? , Error?) ->())
    

}
