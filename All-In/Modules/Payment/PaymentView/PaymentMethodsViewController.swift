//
//  PaymentMethodsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 30/06/2022.
//

import UIKit
import WebKit
//import Braintree
//import BraintreeDropIn



class PaymentMethodsViewController: UIViewController , ChooseAddressDelegate {
  
    @IBOutlet weak var viewIsHiddenConstraints: NSLayoutConstraint!
    @IBOutlet weak var viewIsVisibleConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var paymentScrollView: UIScrollView!
    @IBOutlet weak var addressFullLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var crediCardDetailsView: UIView!
    
    @IBOutlet weak var continueShoppingButton: UIButton!
    @IBOutlet weak var totalAmountLabel: UILabel!
    var totalAmount = ""
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    @IBOutlet weak var crediCardButton: UIButton!
 //   var btApiClient:BTAPIClient!
    var authorization = "sandbox_hcfpdytt_vkh29jtd6t2q4ys8"
    @IBOutlet weak var creditCardWebView: WKWebView!
    
    @IBOutlet weak var placeOrderIndicator: UIActivityIndicatorView!
    let userDefaults = UserDefaults()
    @IBOutlet weak var orderPlacedView: UIView!
    
    var cartItems = [ShoppingCartDB]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
      //  btApiClient = BTAPIClient(authorization: authorization)

    //    btApiClient = BTAPIClient(authorization: authorization)

        orderPlacedView.isHidden = true
        totalAmountLabel.text = totalAmount
        placeOrderButton.layer.cornerRadius = 15
        continueShoppingButton.layer.cornerRadius = 15
       hideView()
        placeOrderButton.isEnabled = false
        placeOrderIndicator.hidesWhenStopped = true
        
      //  if let fullAddress = userDefaults.value(forKey: "fullAddress") as? String{
        //    addressFullLabel.text = fullAddress

        //}

      //  let url = URL(string: "https://www.paypal.com/eg/signin?locale.x=en_EG")
        //creditCardWebView.load(URLRequest(url: url!))
    }

    @IBAction func cashOnDeliveryButton(_ sender: UIButton) {
        hideView()
        cashOnDeliveryButton.layer.borderWidth = 1
        cashOnDeliveryButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        crediCardButton.layer.borderWidth = 0
        placeOrderButton.isEnabled = true
        cartItems.removeAll()
    
    }
         
    @IBAction func creditCardButton(_ sender: UIButton) {
     
        
        cashOnDeliveryButton.layer.borderWidth = 0
        crediCardButton.layer.borderWidth = 1
        crediCardButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        placeOrderButton.isEnabled = false

        //placeOrderButton.isEnabled = true
    }
    
    func didSelectAddress(address: String) {
        addressFullLabel.text = address
    }
    
  
    @IBAction func changeAddressButton(_ sender: UIButton) {
        let addresses = ListOfAddressesViewController()
        navigationController?.pushViewController(addresses, animated: true)
        addresses.chooseAddressDelegate = self
    }
    
    
    
    
    @IBAction func placeOrderButtonPressed(_ sender: UIButton) {
        placeOrderIndicator.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 1.5 , repeats: false) { timer in
            self.placeOrderIndicator.stopAnimating()
            self.orderPlacedView.isHidden = false
        }
    }
    
    
    func hideView(){
        crediCardDetailsView.isHidden = true
        viewIsHiddenConstraints.isActive = true
        viewIsVisibleConstraint.isActive = false
    }
    
    func showView(){
        crediCardDetailsView.isHidden = false
        viewIsHiddenConstraints.isActive = false
           viewIsVisibleConstraint.isActive = true
    }
        
    @IBAction func continueShoppingButtonPressed(_ sender: UIButton) {
        let homeVc = HomeViewController()
        navigationController?.pushViewController(homeVc, animated: true)
      
    }
    
}
////
/*
extension PaymentMethodsViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
            
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
}


extension PaymentMethodsViewController : BTAppSwitchDelegate {
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
         
    }
    
    
    
}
*/
///
