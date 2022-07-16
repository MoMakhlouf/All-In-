//
//  ProfileViewController.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var moreBtnOrders: UIButton!
    @IBOutlet weak var emptyOrder: UIView!
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var moreBtnFavourite: UIButton!
    
    @IBOutlet weak var emptyFavorite: UIView!
    @IBOutlet weak var FavouriteTableView: UITableView!
    
    var ordersArray = [Order]()
    var favArray = [FavouriteDB]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let fav = DBManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyOrder.isHidden =  false
        ordersTableView.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        FavouriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
    
      
        self.userNameLbl.text = "Hi.. " + Helper.shared.getUserEmail()!
        
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        
        let settingBtn = UIBarButtonItem()
        settingBtn.image = UIImage(systemName: "gearshape.fill")
        settingBtn.action = #selector(settingButton)
        settingBtn.target = self
        navigationItem.rightBarButtonItem = settingBtn
        
        let shoppingBagBtn = UIBarButtonItem()
        shoppingBagBtn.image = UIImage(systemName: "bag.fill")
        shoppingBagBtn.action = #selector(shoppingBagButton)
        shoppingBagBtn.target = self
        navigationItem.rightBarButtonItems = [settingBtn, shoppingBagBtn]
        
        favArray = fav.fetchData(appDelegate: appDelegate)
        self.emptyFav()
        
        
        
        let ordersViewModel = OrdersModelView()
        ordersViewModel.fetchData(customerID: "6277923504342")
        ordersViewModel.bindingData = { orders , error in
            if let orders = orders{
                self.ordersArray = orders.orders
                DispatchQueue.main.async {
                    self.ordersTableView.reloadData()
                    self.emptyOrders()
                }
            }
            if let error = error{
               // Alert.displayAlert(title: "Error", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
        
        self.emptyOrders()
        self.emptyFav()
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favArray = fav.fetchData(appDelegate: appDelegate)
        self.emptyOrders()
        self.emptyFav()
        DispatchQueue.main.async {
            self.FavouriteTableView.reloadData()
            self.ordersTableView.reloadData()
        }
        
    }
    
    
/*    override func viewDidAppear(_ animated: Bool) {
      
        favArray = fav.fetchData(appDelegate: appDelegate)
        self.emptyOrders()
        self.emptyFav()
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

 
    @IBAction func moreBtnOrders(_ sender: Any) {
        let orderVC = OrdersViewController()
        navigationController?.pushViewController(orderVC, animated: true)
        
    }
    @IBAction func moreBtnFavourite(_ sender: Any) {
        let favoriteVC = FavoriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
}


extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTableView{
            if ordersArray.count < 2{
                return ordersArray.count
            }else{
                return 2
            }
        }
        if favArray.count < 4{
            return favArray.count
        }else{
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == FavouriteTableView{
            let cell = FavouriteTableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableViewCell
            cell.faveName.text = favArray[indexPath.row].productName
            cell.favePrice.text = favArray[indexPath.row].productPrice
            cell.FavImg.loadFromFave(URLAddress: favArray[indexPath.row].productImage!)
            return cell
        }
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
        cell.nameOfProduct.text = String(ordersArray[indexPath.row].id)
        cell.priceOfOrder.text = ordersArray[indexPath.row].current_total_price
        cell.imgOfOrder.image = UIImage(named: "shoping")
        return cell
    }
}


extension ProfileViewController{
    @objc func settingButton(){
        let settingVC = SettingsViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }

    @objc func shoppingBagButton(){
        let shoppingCart = ShoppingCartViewController()
        navigationController?.pushViewController(shoppingCart, animated: true)
    }
    
}
//extension  ProfileViewController{
//    func setUserInfo(){
//        guard let userName = Helper.shared.getUserName(), let userEmail = Helper.shared.getUserEmail() else {return}
//        self.userName.text = userName
//        self.userEmail.text = userEmail
//    }
//}

extension ProfileViewController{
    func emptyOrders(){
        if ordersArray.isEmpty {
            ordersTableView.isHidden = true
        }else{
            ordersTableView.isHidden = false
        }
    }
    
    func emptyFav(){
        if favArray.isEmpty {
            FavouriteTableView.isHidden = true
        }else{
            FavouriteTableView.isHidden = false
        }
    }
    
}
