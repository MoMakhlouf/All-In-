//
//  SettingsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Settings"
        logoutButton.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
    }

    @IBAction func AddressesButtonPressed(_ sender: UIButton) {
        let adresses = ListOfAddressesViewController()
        navigationController?.pushViewController(adresses, animated: true)
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        showAlertSheet(title: "Do you want to log out?", message:
            "if you pressed log out, we will miss you 💔") { succes in
            if succes {
                Helper.shared.setUserStatus(userIsLogged: false)
                Helper.shared.setFoundAdress(isFoundAddress: false)
                let logout = MyAccountViewController()
                self.navigationController?.pushViewController(logout, animated: true)
            }
        }
        
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
