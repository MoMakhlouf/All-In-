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
    
    @IBOutlet weak var notLoginView: UIView!
    
    @IBOutlet weak var profileScrollView: UIScrollView!
    var ordersArray = [Order]()
    var favArray = [FavouriteDB]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let fav = DBManager.sharedInstance
    
    var currency = ""
    var usdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        
        isUserLogged()
        
        emptyOrder.isHidden = false
        ordersTableView.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        FavouriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
    
      //  notLoginView.isHidden = true
      
        self.userNameLbl.text = "Hi, " + (UserDefault.shared.getUserName() ?? "")
        
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
        ordersViewModel.fetchData(customerID: UserDefault.shared.getUserID()!)
        ordersViewModel.bindingData = { orders , error in
            if let orders = orders{
                self.ordersArray = orders.orders
                DispatchQueue.main.async {
                    self.ordersTableView.reloadData()
                    self.emptyOrders()
                }
            }
            if let error = error{
               // Alert.displayAlert(title: "Error", message: "Orders can't be loaded")
                print(error.localizedDescription)
            }
           
        }
        print("zzz\(ordersArray)")
        
        
        self.emptyOrders()
        self.emptyFav()
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isUserLogged()
        self.userNameLbl.text = "Hi, " + (UserDefault.shared.getUserName() ?? "")

        favArray = fav.fetchData(appDelegate: appDelegate)
        self.emptyOrders()
        self.emptyFav()
        DispatchQueue.main.async {
            self.FavouriteTableView.reloadData()
            self.ordersTableView.reloadData()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func isUserLogged() {
        
        UserDefault.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.profileScrollView.isHidden = false
                self.navigationController?.navigationBar.isHidden = false

            }else{
                self.profileScrollView.isHidden = true
                self.navigationController?.navigationBar.isHidden = true
            }
        }
        
    }
    
    
    @IBAction func signInIfNotLogin(_ sender: UIButton) {
        let login = LoginViewController()
        navigationController?.pushViewController(login, animated: true)
    }
    
    @IBAction func registerIfNotLogin(_ sender: UIButton) {
        let register = RgisterViewController()
        navigationController?.pushViewController(register, animated: true)
    }
    
    
/*    override func viewDidAppear(_ animated: Bool) {
      
        favArray = fav.fetchData(appDelegate: appDelegate)
        self.emptyOrders()
        self.emptyFav()
    }
    */

    @IBAction func LogOutBtnPressed(_ sender: Any) {
        let home = HomeViewController()
        navigationController?.pushViewController(home, animated: true)
    }
    

 
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
            
            if currency == "USD"{
                cell.favePrice.text = (favArray[indexPath.row].productPrice ?? "") + " USD"
            }else{
                let price = Double(favArray[indexPath.row].productPrice!)! * Double(usdValue)!
                cell.favePrice.text = String(format: "%.2f", price) + " EGP"
            }
            
            
            
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


