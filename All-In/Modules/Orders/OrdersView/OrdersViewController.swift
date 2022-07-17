//
//  MyAccountViewController.swift
//  All-In
//
//  Created by Marwa on 02/07/2022.
//

import UIKit

class OrdersViewController: UIViewController {
    var ordersArray = [Order]()
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var emptyOrder: UIView!
    
    var currency = ""
    var usdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        ordersTable.delegate = self
        ordersTable.dataSource = self
        ordersTable.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        // register Header
        ordersTable.register(UINib(nibName: "orderHeaderTableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "orderHeaderTableView")
        ordersTable.register(UINib(nibName: "FooterOrderTableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FooterOrderTableView")
        
        title = "Orders"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 20.0)!]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        
        self.emptyOrders()
        
    }

}

extension OrdersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "orderHeaderTableView") as! orderHeaderTableView
        headerView.noOfOrder.text =  String(ordersArray[section].id)
      
//        headerView.dateOfOrder.text = "Placed On " + ordersArray[section].created_at
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterOrderTableView") as! FooterOrderTableView
        if currency == "USD" {
            footerView.totalPrice.text = ordersArray[section].current_total_price + " USD"
        }else{
           
            let egpPrice = Double(ordersArray[section].current_total_price)! * Double(usdValue)!
            
            footerView.totalPrice.text = String(format: "%.2f", egpPrice) + " EGP"

        }
        
        return footerView
        }
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 50
        }

}

extension OrdersViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersArray[section].line_items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
        
        cell.nameOfProduct.text = ordersArray[indexPath.section].line_items[indexPath.row].title
        cell.imgOfOrder.kf.setImage(with: URL(string: ordersArray[indexPath.section].line_items[indexPath.row].sku))
        
        if currency == "USD"{
            cell.priceOfOrder.text = ordersArray[indexPath.section].line_items[indexPath.row].price + " USD"

        } else{
             let egpPrice = Double(ordersArray[indexPath.section].line_items[indexPath.row].price)! * Double(usdValue)!

            cell.priceOfOrder.text = String(format: "%.2f", egpPrice) + " EGP"
        }
        return cell
    }
    
}



extension OrdersViewController{
    func emptyOrders(){
        if ordersArray.isEmpty {
            ordersTable.isHidden = true
        }else{
            ordersTable.isHidden = false
        }
    }

}
