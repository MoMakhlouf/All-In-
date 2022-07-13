//
//  SettingsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var currencySwitch: UISegmentedControl!
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
    
    
    
    @IBAction func currencySwitchControlPressed(_ sender: UISegmentedControl) {
        
        switch currencySwitch.selectedSegmentIndex {
        
        case 0 : Defaults.defaults.setCurrency(key: "currency", value: "USD")
        case 1 : Defaults.defaults.setCurrency(key: "currency", value: "EGP")
        
        default:
            break
        }
        print(currencySwitch.titleForSegment(at: currencySwitch.selectedSegmentIndex)!)
    }
    
    
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        
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
