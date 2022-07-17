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
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.delegate = self
        ordersTable.dataSource = self
        ordersTable.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        // register Header
        ordersTable.register(UINib(nibName: "orderHeaderTableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "orderHeaderTableView")

        
        title = "Orders"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 25.0)!]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        
        let ordersViewModel = OrdersModelView()
        ordersViewModel.fetchData(customerID: UserDefault.shared.getUserID()!)
        ordersViewModel.bindingData = { orders , error in
            if let orders = orders{
                self.ordersArray = orders.orders
                DispatchQueue.main.async {
                    self.ordersTable.reloadData()
                    self.emptyOrders()
                }
            }
            if let error = error{
               // Alert.displayAlert(title: "Error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
        self.emptyOrders()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension OrdersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "orderHeaderTableView") as! orderHeaderTableView
        headerView.noOfOrder.text = "Order " + String(ordersArray[section].id)
      
        headerView.dateOfOrder.text = "Placed On " + ordersArray[section].created_at
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}

extension OrdersViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
        
        cell.nameOfProduct.text = ordersArray[indexPath.section].line_items[0].title
        cell.priceOfOrder.text = ordersArray[indexPath.section].current_total_price + ordersArray[indexPath.section].currency
        cell.imgOfOrder.image = UIImage(named: "shoping")
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
