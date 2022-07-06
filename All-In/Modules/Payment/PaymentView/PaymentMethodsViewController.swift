//
//  PaymentMethodsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 30/06/2022.
//

import UIKit
import WebKit
import Braintree
import BraintreeDropIn



class PaymentMethodsViewController: UIViewController {
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
    var btApiClient:BTAPIClient!
    var authorization = "sandbox_hcfpdytt_vkh29jtd6t2q4ys8"
    @IBOutlet weak var creditCardWebView: WKWebView!
    
    @IBOutlet weak var placeOrderIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var orderPlacedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btApiClient = BTAPIClient(authorization: authorization)
        orderPlacedView.isHidden = true
        totalAmountLabel.text = totalAmount
        placeOrderButton.layer.cornerRadius = 15
        continueShoppingButton.layer.cornerRadius = 15
       hideView()
        placeOrderButton.isEnabled = false
        placeOrderIndicator.hidesWhenStopped = true

      //  let url = URL(string: "https://www.paypal.com/eg/signin?locale.x=en_EG")
        //creditCardWebView.load(URLRequest(url: url!))
    }

    @IBAction func cashOnDeliveryButton(_ sender: UIButton) {
        hideView()
        cashOnDeliveryButton.layer.borderWidth = 1
        cashOnDeliveryButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        crediCardButton.layer.borderWidth = 0
        placeOrderButton.isEnabled = true
    
    }
         
    @IBAction func creditCardButton(_ sender: UIButton) {
       // showView()
       // showDropIn(clientTokenOrTokenizationKey: apiClient)
    //    startCheckout()
  // showDropIn(clientTokenOrTokenizationKey: apiClient)
        payPalCheckout()
        
        cashOnDeliveryButton.layer.borderWidth = 0
        crediCardButton.layer.borderWidth = 1
        crediCardButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        placeOrderButton.isEnabled = false

        //placeOrderButton.isEnabled = true
    }
    
    
//    func showDropIn(clientTokenOrTokenizationKey: String) {
//        let request =  BTDropInRequest()
//        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
//        { (controller, result, error) in
//
//            if (error != nil) {
//                print("ERROR")
//            } else if (result?.isCancelled == true) {
//               print("CANCELED")
//            } else if let result = result {
//             //    Use the BTDropInResult properties to update your UI
//               //  result.paymentMethodType
////                  result.paymentMethod
////                result.paymentIcon
////                 result.paymentDescription
//            }
//
//            controller.dismiss(animated: true, completion: nil)
//        }
//        self.present(dropIn!, animated: true, completion: nil)
//    }
    
    
    
    func payPalCheckout (){

        let payPalDriver = BTPayPalDriver(apiClient: btApiClient)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self // Optional
        
        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalRequest(amount: "2.32")
        request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
        
        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                
                // Access additional information
                let email = tokenizedPayPalAccount.email
                debugPrint(email)
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                
                // See BTPostalAddress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                // Handle error here...
                print(error)
            } else {
                // Buyer canceled payment approval
            }
        }

    }

    
    
    
//    func startCheckout() {
//           // Example: Initialize BTAPIClient, if you haven't already
//           btApiClient = BTAPIClient(authorization: apiClient)!
//        let payPalDriver = BTPayPalDriver(apiClient: btApiClient)
//
//           // Specify the transaction amount here. "2.32" is used in this example.
//           let request = BTPayPalRequest(amount: "2.32")
//           request.currencyCode = "USD" // Optional; see BTPayPalCheckoutRequest.h for more options
//
//        payPalDriver.requestBillingAgreement(request) { paypalAccount, error in
//            if paypalAccount != nil{
//
//            } else if  let error = error {
//                print("error")
//            }else {
//                   // Buyer canceled payment approval
//               }
//           }
//       }
    
    
//    func showDropIn(clientTokenOrTokenizationKey: String) {
//        let request =  BTDropInRequest()
//        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
//        { (controller, result, error) in
//            if (error != nil) {
//                print("ERROR")
//            } else if (result?.isCancelled == true) {
//                print("CANCELED")
//            } else if let result = result {
//                // Use the BTDropInResult properties to update your UI
//             //   let selectedPaymentMethodType = result.paymentMethodType
//                let selectedPaymentMethod = result.paymentMethod
//                let selectedPaymentMethodIcon = result.paymentIcon
//                let selectedPaymentMethodDescription = result.paymentDescription
//            }
//            controller.dismiss(animated: true, completion: nil)
//        }
//        self.present(dropIn!, animated: true, completion: nil)
//    }
    
    
    
    
    
    
    
    
    @IBAction func changeAddressButton(_ sender: UIButton) {
        let addresses = ListOfAddressesViewController()
        navigationController?.pushViewController(addresses, animated: true)
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
