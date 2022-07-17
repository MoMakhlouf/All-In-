//
//  SettingsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cartDB = ShoppingCartDBManager.sharedInstance
    var cartItems = [ShoppingCartDB]()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.systemGray6

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.white

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
                
                self.afterConvertCurrency()
        
                
              //  self.navigationController?.popToRootViewController(animated: true)
            }
            
        case 1 : Defaults.defaults.setCurrency(key: "currency", value: "EGP")
            userdefault.set(segmentEGP , forKey: segmentConvert)
            loadIndicator.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 1.5 , repeats: false) { timer in
                self.afterConvertCurrency()
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

                print("Delete All item from shopping cart")
                print(self.cartItems.count)
                if self.cartDB.deleteAll(appDelegate: self.appDelegate) {
                    self.cartItems = self.cartDB.getItemToCart(appDelegate: self.appDelegate)
                    print(self.cartItems.count)
                  print("deleted")
                }
                
                self.afterConvertCurrency()
            }
        }
        
    }
    
    
    func afterConvertCurrency() {
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
                    , let splashViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "splash") as? ViewController else { return  }
            let navigationController = UINavigationController(rootViewController: splashViewController)
            window.rootViewController = navigationController
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.1
            UIView.transition(with: window, duration: duration, options: options, animations: {})
        }

}
