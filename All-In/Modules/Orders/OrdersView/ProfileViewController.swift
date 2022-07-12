//
//  ProfileViewController.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var moreBtnOrders: UIButton!
    @IBOutlet weak var ordersTableView: UITableView!
    
    
    @IBOutlet weak var moreBtnFavourite: UIButton!
    @IBOutlet weak var FavouriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersTableView.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        
        
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
    }
    

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
        let favoriteVC = FavouriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
}


extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTableView{
            return 2
        }
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
        cell.numberOfOrder.text = "1234568" + "mdgjk"
        cell.dateOfOrder.text = "12/5/6"
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
