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
    
    @IBOutlet weak var addressFullLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var crediCardDetailsView: UIView!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    var totalAmount = ""
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    @IBOutlet weak var crediCardButton: UIButton!
    var btApiClient:BTAPIClient!
    var apiClient = "sandbox_8hz98pnr_k56tz22gdk2xz7rt"
    @IBOutlet weak var creditCardWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        totalAmountLabel.text = totalAmount
        placeOrderButton.layer.cornerRadius = 15
       hideView()
        placeOrderButton.isEnabled = false
       

        let url = URL(string: "https://www.paypal.com/eg/signin?locale.x=en_EG")
        creditCardWebView.load(URLRequest(url: url!))
    }

    @IBAction func cashOnDeliveryButton(_ sender: UIButton) {
        hideView()
        cashOnDeliveryButton.layer.borderWidth = 1
        cashOnDeliveryButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        crediCardButton.layer.borderWidth = 0
        placeOrderButton.isEnabled = true
        
       // showDropIn(clientTokenOrTokenizationKey: apiClient)
    }
    
    @IBAction func creditCardButton(_ sender: UIButton) {
//showView()
        cashOnDeliveryButton.layer.borderWidth = 0
        crediCardButton.layer.borderWidth = 1
        crediCardButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        placeOrderButton.isEnabled = true
        
     startCheckout()
    }
    
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
    
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
               print("CANCELED")
            } else if let result = result {
             //    Use the BTDropInResult properties to update your UI
               //  result.paymentMethodType
                  result.paymentMethod
                result.paymentIcon
                 result.paymentDescription
            }
            
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    
    
    //----------
//    func payPalCheckout (totalAmount : String){
//        self.btApiClient = BTAPIClient(authorization: apiClient)
//    let payPalDriver = BTPayPalDriver(apiClient: btApiClient)
//     //   payPalDriver.viewControllerPresentingDelegate = self
//      //  payPalDriver.appSwitchDelegate = self
//        let request =  BTPayPalRequest(amount: totalAmount)
//        request.currencyCode = "USD"
//      //  request.billingAgreementDescription = totalAmount
//        //BTPayPalCheckoutRequest(amount: totalAmount)
//    // or let request = BTPayPalVaultRequest()
//
//        payPalDriver.requestOneTimePayment(request) { [weak self] (tokenizedPayPalAccount, error) in
//        if let tokenizedPayPalAccount = tokenizedPayPalAccount{
//            print(tokenizedPayPalAccount.nonce)
//
//            let email = tokenizedPayPalAccount.email
//            let firstname = tokenizedPayPalAccount.firstName
//        }else if let error = error {
//            print("errrrrror")
//        }else{
//            print("order canceled")
//        }
//
//     }
//    }
    
    
    func startCheckout() {
           // Example: Initialize BTAPIClient, if you haven't already
           btApiClient = BTAPIClient(authorization: apiClient)!
        let payPalDriver = BTPayPalDriver(apiClient: btApiClient)

           // Specify the transaction amount here. "2.32" is used in this example.
           let request = BTPayPalRequest(amount: "2.32")
           request.currencyCode = "USD" // Optional; see BTPayPalCheckoutRequest.h for more options

        payPalDriver.requestBillingAgreement(request) { paypalAccount, error in
            if paypalAccount != nil{
                
            } else if  let error = error {
                print("error")
            }else {
                   // Buyer canceled payment approval
               }
           }
       }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func placeOrderButtonPressed(_ sender: UIButton) {
        
        let address = AddNewAddressViewController()
        
        navigationController?.pushViewController(address, animated: true)
        
       // Alert.displayAlert(title: "Order placed Successfully !", message: " ✔ ")
        
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
        
    
}


extension PaymentMethodsViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
            
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
}
