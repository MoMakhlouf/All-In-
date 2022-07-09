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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyCartView.isHidden = true
        proceedToCheckoutButton.layer.cornerRadius = 12
        navigationItem.title = "Shopping Cart"
        
        
        for item in cartItems {
            total += 1
            let price = Double(item.price ?? "5")
            total += ( price! * Double(item.itemQuantity))
            print(item.itemQuantity)
        }
    

//        cartItems.forEach({ item in
//            print("\(item.price)")
//            let price = Double(item.price ?? "5")
//            total += (price! * Double(item.itemQuantity))
//            print( "asasas\(total)")
//            print(item.itemQuantity)
//        })
    

       
        totalPrice.text = "Total: \(total)"
        emptyCart()
        getItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        shoppingCartTableView.reloadData()
        emptyCart()
    }
    
    
    //MARK: - Get Items From CoreData
    func getItems(){
        cartItems = cartDB.getItemToCart(appDelegate: appDelegate)
        print(cartItems.count)
          DispatchQueue.main.async {
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
            self.totalPrice.text = "\(self.total)"
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        cell.didTapMin = { [weak self] in
            guard let self = self else {return}
            let item = self.cartItems[indexPath.row]
            if item.itemQuantity <= 1  {
                let alert = UIAlertController(title: " Warning", message: "at least one Item ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
                self.present(alert, animated: true, completion: nil)
                return }
            let price = Double(item.price!)
            self.total -= price!
            self.cartItems[indexPath.row].itemQuantity -= 1
            self.totalPrice.text = "\(self.total)"
            tableView.reloadRows(at: [indexPath], with: .none)
        }
       return cell
    }

    
}



 
extension ShoppingCartViewController : DeletionDelegate{
    func deleteCartItem(indexPath: IndexPath) {
        
       cartItems.remove(at : indexPath.row)
        self.shoppingCartTableView.reloadData()
        emptyCart()
    }
    
    
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingCartTableView.beginUpdates()
            ShoppingCartDBManager.sharedInstance.deleteFromCart(cartItem: cartItems[indexPath.row], indexPath: indexPath, appDelegate: appDelegate, delegate: self)
            shoppingCartTableView.deleteRows(at: [indexPath] ,with: .automatic)
             emptyCart()
            shoppingCartTableView.endUpdates()
        }
    }

}
