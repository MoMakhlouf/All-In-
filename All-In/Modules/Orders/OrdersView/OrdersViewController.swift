//
//  OrdersViewController.swift
//  All-In
//
//  Created by Marwa on 02/07/2022.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) //UIColor.black.cgColor
        
        loginBtn.layer.borderWidth = 2
        loginBtn.layer.cornerRadius = 15
        
        registerBtn.layer.borderColor = UIColor.black.cgColor
        registerBtn.layer.borderWidth = 2
        registerBtn.layer.cornerRadius = 15
        
        title = "My Account"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 25.0)!]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func registerBtn(_ sender: Any) {
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
    }

}
