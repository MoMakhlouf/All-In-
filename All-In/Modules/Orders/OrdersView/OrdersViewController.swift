//
//  MyAccountViewController.swift
//  All-In
//
//  Created by Marwa on 02/07/2022.
//

import UIKit

class OrdersViewController: UIViewController {
    
   
    @IBOutlet weak var ordersTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.delegate = self
        ordersTable.dataSource = self
        ordersTable.register(UINib(nibName: "OrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        

        
        title = "My Account"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 25.0)!]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        
        let settingBtn = UIBarButtonItem()
        let me = MyAccountViewController()
        settingBtn.image = UIImage(systemName: "gearshape.fill")
        settingBtn.action = #selector(me.settingButton)
        settingBtn.target = self
        navigationItem.rightBarButtonItem = settingBtn
        
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
    
}

extension OrdersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
        cell.numberOfOrder.text = "1234568" + "mdgjk"
        cell.dateOfOrder.text = "12/5/6"
        return cell
    }
    
}

/*extension MyAccountViewController{
    @objc func setting_Button(){
        let settingVC = SettingsViewController()
        navigationController?.pushViewController(settingVC, animated: true)
        
    }
}*/
