//
//  ShoppingCartViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var shoppingCartTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    var itemData = [ShoppingCartItem]()
    var total = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
        
        
        shoppingCartTableView.register(UINib(nibName: "ShoppingCartTableViewCell", bundle: nil), forCellReuseIdentifier: "shopCartCell")
        proceedToCheckoutButton.layer.cornerRadius = 12
        
        navigationItem.title = "Shopping Cart"
        
        itemData.append(ShoppingCartItem(itemPrice: 100 , itemName: "Adidas ultraBoost", itemImage: "hi", itemQuantity: 1))
        itemData.append(ShoppingCartItem(itemPrice: 550.50 , itemName: "blalbalalb", itemImage: "hi" , itemQuantity: 4))
        itemData.append(ShoppingCartItem(itemPrice:  500 , itemName: "asdsssqqad", itemImage: "hi" , itemQuantity: 1))

        itemData.forEach({ item in
            total += (item.itemPrice * Double(item.itemQuantity))
        })
        totalPrice.text = "\(total)"
    }

    @IBAction func ProceedToCheckOut(_ sender: UIButton) {
        let payment = PaymentViewController()
        payment.subtotal = total
        navigationController?.pushViewController(payment, animated: true)
    }

}


extension ShoppingCartViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return itemData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shoppingCartTableView.dequeueReusableCell(withIdentifier: "shopCartCell", for: indexPath) as! ShoppingCartTableViewCell
        
       
        
        cell.itemsInCell(itemData[indexPath.row])
        
        cell.didTapPlus = { [weak self] in
            guard let self = self else {return}
            let item = self.itemData[indexPath.row]
            if item.itemQuantity >= 5 {return}
            self.total += item.itemPrice
            self.itemData[indexPath.row].itemQuantity += 1
            self.totalPrice.text = "\(self.total)"
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        cell.didTapMin = { [weak self] in
            guard let self = self else {return}
            let item = self.itemData[indexPath.row]
            if item.itemQuantity <= 1 {return}
            self.total -= item.itemPrice
            self.itemData[indexPath.row].itemQuantity -= 1
            self.totalPrice.text = "\(self.total)"
            tableView.reloadRows(at: [indexPath], with: .none)
        }
       return cell
    }
    
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingCartTableView.beginUpdates()
            shoppingCartTableView.deleteRows(at: [indexPath] ,with: .fade)
            shoppingCartTableView.endUpdates()
        }
    }
}
