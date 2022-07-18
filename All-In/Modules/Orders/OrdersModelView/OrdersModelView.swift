//
//  OrdersModelView.swift
//  All-In
//
//  Created by Marwa on 14/07/2022.
//

import Foundation

class OrdersModelView{
//
//    var ordersArray: Orders?{
//        didSet{
//            bindingData(ordersArray, nil)
//        }
//    }
//    var error: Error?{
//        didSet{
//            bindingData(nil , error)
//
//        }
//    }
//
//    let apiService : ApiServices
//    var bindingData: ((Orders? , Error?) -> Void) = {_ , _ in}
//    init(apiService :ApiServices = NetworkManager()){
//        self.apiService = apiService
//    }
//    func fetchData(){
//        apiService.getOrder(){ orders, error in
//            if let orders = orders {
//                self.ordersArray = orders
//                print("fffff")
//            }
//            if let error = error {
//                self.error = error
//                print("falseee")
//            }
//        }
//    }
    
    var ordersArray: Orders?{
        didSet{
            bindingData(ordersArray, nil)
        }
    }
    var error: Error?{
        didSet{
            bindingData(nil , error)

        }
    }

    let apiService : ApiServices
    var bindingData: ((Orders? , Error?) -> Void) = {_ , _ in}
    init(apiService :ApiServices = NetworkManager()){
        self.apiService = apiService
    }
    func fetchData(customerID: Int ){
        apiService.getOrder(customerID: customerID){ orders, error in
            if let orders = orders {
                self.ordersArray = orders
            }
            if let error = error {
                self.error = error
            }
        }
    }
}
