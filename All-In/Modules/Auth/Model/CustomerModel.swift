//
//  CustomerModel.swift
//  All-In
//
//  Created by Mahmoud Saad on 11/07/2022.
//

import Foundation
struct NewCustomr: Codable {

    let customer: Customr

}



struct AllCustomers: Codable {

    let customers: [Customr]

}



struct Customr: Codable {

    // tags is password

    var first_name, email, tags: String?

    var id: Int?

    var addresses: [Address]?

    // token for firebase

    var lastName: String?

}



struct Addresss: Codable {

    var id : Int?

    var customer_id : Int?

    var address1, city: String?

    var country: String?

    var phone : String?

}



struct NewAddresss : Codable{

    var customer_address : Address?

}



struct CustomerAddresss: Codable {

    var addresses: [Address]?

}



struct Addressess: Codable {

    var addresses: Address

}



extension Encodable {

  func asDictionary() throws -> [String: Any] {

    let data = try JSONEncoder().encode(self)

    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {

      throw NSError()

    }

    return dictionary

  }

}
 
