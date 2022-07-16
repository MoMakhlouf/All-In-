//
//  SettingsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var currencySwitch: UISegmentedControl!
    @IBOutlet weak var logoutButton: UIButton!
    let userdefault = UserDefaults.standard

    let segmentConvert = "segment"
    let segmentUSD = "segmentUSD"
    let segmentEGP = "segmentEGP"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadIndicator.hidesWhenStopped = true
        
        navigationItem.title = "Settings"
        logoutButton.layer.cornerRadius = 15
        updateSegment()
        
        navigationController?.navigationBar.backgroundColor = UIColor.systemGray6
    }
    

    @IBAction func AddressesButtonPressed(_ sender: UIButton) {
        let adresses = ListOfAddressesViewController()
        navigationController?.pushViewController(adresses, animated: true)
    }
    
    func updateSegment(){
        let  segment = userdefault.string(forKey: segmentConvert)
        if    segment == segmentUSD {
            currencySwitch.selectedSegmentIndex = 0
        }else if segment == segmentEGP {
            currencySwitch.selectedSegmentIndex = 1

        }
    }
    
    
    @IBAction func currencySwitchControlPressed(_ sender: UISegmentedControl) {
        switch currencySwitch.selectedSegmentIndex {
        
        case 0 : Defaults.defaults.setCurrency(key: "currency", value: "USD")
            userdefault.set(segmentUSD , forKey: segmentConvert)
            loadIndicator.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 1.5 , repeats: false) { timer in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        case 1 : Defaults.defaults.setCurrency(key: "currency", value: "EGP")
            userdefault.set(segmentEGP , forKey: segmentConvert)
            loadIndicator.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 1.5 , repeats: false) { timer in
                self.navigationController?.popToRootViewController(animated: true)
            }
        default:
            break
        }
        
        
        print(currencySwitch.titleForSegment(at: currencySwitch.selectedSegmentIndex)!)
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
