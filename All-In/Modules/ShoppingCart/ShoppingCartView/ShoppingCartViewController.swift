//
//  ShoppingCartViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var shoppingCartTableView: UITableView!{
        didSet{
            shoppingCartTableView.delegate = self
            shoppingCartTableView.dataSource = self
            shoppingCartTableView.register(UINib(nibName: "ShoppingCartTableViewCell", bundle: nil), forCellReuseIdentifier: "shopCartCell")
        }
    }
    @IBOutlet weak var totalPrice: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cartDB = ShoppingCartDBManager.sharedInstance
    var cartItems = [ShoppingCartDB]()
    var total = 0.0
    
    
    var currency = ""
    var usdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 20.0)!]
        
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        
        emptyCartView.isHidden = true
        proceedToCheckoutButton.layer.cornerRadius = 12
        navigationItem.title = "Shopping Cart"
        
        getItems()
        
        DispatchQueue.main.async {
            self.convert()
        }
       
        emptyCart()
        
    }
    //MARK: - CONVERT CURRENCY
    func convert(){
        if self.currency == "USD"{
            self.totalPrice.text = "Total: \(String(format: "%.2f", self.total)) USD "
        }else{
            let totalValue = self.total * Double(self.usdValue)!
            self.totalPrice.text = "Total: \(String(format: "%.2f", totalValue)) EGP"

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        shoppingCartTableView.reloadData()
        convert()
        emptyCart()
    }
      
    
    
    //MARK: - Get Items From CoreData
    func getItems(){
      
        cartItems = cartDB.getItemToCart(appDelegate: appDelegate)

        print(cartItems.count)
          DispatchQueue.main.async {
              
              self.cartItems.forEach({ item in
                  let price = Double(item.price ?? " ")
                  self.total += (price! * Double(item.itemQuantity))
                  
              })
              
            self.shoppingCartTableView.reloadData()
      }
    }
    
    //MARK: - check cart if Empty
    func emptyCart(){
        if cartItems.isEmpty {
            emptyCartView.isHidden = false
        }else{
            emptyCartView.isHidden = true
        }
    }
    

    @IBAction func ProceedToCheckOut(_ sender: UIButton) {
        let payment = PaymentViewController()
        payment.subtotal = total
        navigationController?.pushViewController(payment, animated: true)
    }

}

extension ShoppingCartViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shoppingCartTableView.dequeueReusableCell(withIdentifier: "shopCartCell", for: indexPath) as! ShoppingCartTableViewCell
      
            cell.itemsInCell(cartItems[indexPath.row])

        cell.didTapPlus = { [weak self] in
            guard let self = self else {return}
            let item = self.cartItems[indexPath.row]
            if item.itemQuantity >= 5 {
                let alert = UIAlertController(title: "Not Available", message: "maximum Quantity is 5 ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
                self.present(alert, animated: true, completion: nil)
                return}
            let price = Double(item.price ?? "1")
            self.total += price ?? 1
            self.cartItems[indexPath.row].itemQuantity += 1
            self.convert()
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        
        cell.didTapMin = { [weak self] in
            guard let self = self else {return}
            let item = self.cartItems[indexPath.row]
            if item.itemQuantity <= 1  {
                let alert = UIAlertController(title: " Warning", message: "At least one Item ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
                self.present(alert, animated: true, completion: nil)
                return }
            let price = Double(item.price!)
            self.total -= price!
            self.cartItems[indexPath.row].itemQuantity -= 1
            self.convert()

            tableView.reloadRows(at: [indexPath], with: .none)
        }
//            }
//        }
       return cell
    }
    
  
}
 
//MARK: - Delete shopping cart items

extension ShoppingCartViewController : DeletionDelegate{
    func deleteCartItem(indexPath: IndexPath) {
        
       cartItems.remove(at : indexPath.row)
   
        DispatchQueue.main.async {
            self.shoppingCartTableView.reloadData()
        }

        emptyCart()
    }
    
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete {
          
            let alert = UIAlertController(title: "Delete Item", message: "Are you want to delete this Item ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] UIAlertAction in
                self.total = total -  ( Double(self.cartItems[indexPath.row].price!)! * Double(self.cartItems[indexPath.row].itemQuantity))
                convert()
                shoppingCartTableView.beginUpdates()
                
                ShoppingCartDBManager.sharedInstance.deleteFromCart(cartItem: cartItems[indexPath.row], indexPath: indexPath, appDelegate: appDelegate, delegate: self)
                shoppingCartTableView.deleteRows(at: [indexPath] ,with: .automatic)
                               
                shoppingCartTableView.endUpdates()
             }))
            self.present(alert, animated: true, completion: nil)
            
            shoppingCartTableView.reloadData()

             emptyCart()

        }
    }
}
