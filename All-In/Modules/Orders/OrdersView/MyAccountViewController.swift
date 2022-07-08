



//
//  MyAccountViewController.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) //UIColor.black.cgColor
        
        loginBtn.layer.borderWidth = 2
        loginBtn.layer.cornerRadius = 15
        
        registerBtn.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        registerBtn.layer.borderWidth = 2
        registerBtn.layer.cornerRadius = 15
        
        title = "My Account"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 25.0)!]
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        
        let settingBtn = UIBarButtonItem()
        settingBtn.image = UIImage(systemName: "gearshape.fill")
        settingBtn.action = #selector(settingButton)
        settingBtn.target = self
        navigationItem.leftBarButtonItem = settingBtn
        
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
        let register = RgisterViewController()
            navigationController?.pushViewController(register, animated: true)
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
    let login = LoginViewController()
        navigationController?.pushViewController(login, animated: true)
    }

}


extension MyAccountViewController{
    @objc func settingButton(){
        let settingVC = SettingsViewController()
        navigationController?.pushViewController(settingVC, animated: true)
        
    }
}
