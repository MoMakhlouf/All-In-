//
//  PaymentMethodsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 30/06/2022.
//

import UIKit
import WebKit
import Braintree

class PaymentMethodsViewController: UIViewController  {
  
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cartDB = ShoppingCartDBManager.sharedInstance
    var cartItems = [ShoppingCartDB]()
    
  
    @IBOutlet weak var viewIsHiddenConstraints: NSLayoutConstraint!
    @IBOutlet weak var viewIsVisibleConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var paymentScrollView: UIScrollView!
    @IBOutlet weak var addressFullLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var crediCardDetailsView: UIView!
    @IBOutlet weak var continueShoppingButton: UIButton!
    @IBOutlet weak var totalAmountLabel: UILabel!
    var totalAmount = 0.0
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    @IBOutlet weak var crediCardButton: UIButton!
    var braintreeAPIClient:BTAPIClient!
    let authorization = "sandbox_w3d87wk7_hc7cj2xjtg337ffs"
    @IBOutlet weak var creditCardWebView: WKWebView!
    @IBOutlet weak var placeOrderIndicator: UIActivityIndicatorView!
    let userDefaults = UserDefaults()
    @IBOutlet weak var orderPlacedView: UIView!
    var addressesArray = [Address]()
    @IBOutlet weak var changeButton: UIButton!
   
    var currency = ""
    var usdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalAmountLabel.text = "\(totalAmount)"
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
   
        orderPlacedView.isHidden = true
        placeOrderButton.layer.cornerRadius = 15
        continueShoppingButton.layer.cornerRadius = 15
        hideView()
        placeOrderButton.isEnabled = false
        placeOrderIndicator.hidesWhenStopped = true
        
        getChosenAddress()
        
        if currency == "USD"{
        totalAmountLabel.text = "Total: \(totalAmount) USD"
        }else{
           let totalEgp = totalAmount * Double(usdValue)!
            
            totalAmountLabel.text = "Total: \( String(format: "%.2f", totalEgp)) EGP"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
     getChosenAddress()
        
        if currency == "USD"{
        totalAmountLabel.text = "Total: \(totalAmount) USD"
        }else{
           let totalEgp = totalAmount * Double(usdValue)!
            
            totalAmountLabel.text = "Total: \( String(format: "%.2f", totalEgp)) EGP"

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func payPalCheckout (amount : String){
        self.braintreeAPIClient = BTAPIClient(authorization: authorization)
            let payPalDriver = BTPayPalDriver(apiClient: braintreeAPIClient)
            let request = BTPayPalCheckoutRequest(amount: amount)
            request.currencyCode = "USD"
        request.displayName =  Helper.shared.getUserName()
        
            var err:Error?
           payPalDriver.tokenizePayPalAccount(with: request) { [weak self] (tokenizedPayPalAccount, error) in
            if tokenizedPayPalAccount != nil {
            }else if let error = error {
                err = error
                print("error is \(error)")
            }

            if err == nil{
                print("")
            }
        }
    }

    //MARK: - Calling address
    
    func getChosenAddress(){
        addressFullLabel.text = Defaults.defaults.getAddress(key: "address")

        if addressFullLabel.text == ""{
            self.addressFullLabel.text = "Please, add new Address"
               self.placeOrderButton.isEnabled = false
               self.changeButton.titleLabel?.text = "Add"
        }
        
    }
    

    //MARK: - SELECTING CASH ON DELEIVERY
    @IBAction func cashOnDeliveryButton(_ sender: UIButton) {
        hideView()
        cashOnDeliveryButton.layer.borderWidth = 1
        cashOnDeliveryButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        crediCardButton.layer.borderWidth = 0
        placeOrderButton.isEnabled = true
        
    }
    
    //MARK: - SELECTING PAYPAL
    @IBAction func creditCardButton(_ sender: UIButton) {
       
        payPalCheckout(amount: "\(totalAmount)")
        cashOnDeliveryButton.layer.borderWidth = 0
        crediCardButton.layer.borderWidth = 1
        crediCardButton.layer.borderColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        placeOrderButton.isEnabled = false
    }
    
    func didSelectAddress(address: String) {
        addressFullLabel.text = address
    }
    
  
    @IBAction func changeAddressButton(_ sender: UIButton) {
        let addresses = ListOfAddressesViewController()
        navigationController?.pushViewController(addresses, animated: true)
    }
    
    
    //MARK: - OREDER CONFIRMATION
    @IBAction func placeOrderButtonPressed(_ sender: UIButton) {
        placeOrderIndicator.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 1.5 , repeats: false) { timer in
            self.placeOrderIndicator.stopAnimating()
            self.orderPlacedView.isHidden = false
            self.navigationController?.navigationBar.isHidden = true
        }
       

        print("Delete All item from shopping cart")
        print(cartItems.count)
        if cartDB.deleteAll(appDelegate: appDelegate) {
            cartItems = cartDB.getItemToCart(appDelegate: appDelegate)
            print(cartItems.count)
          print("deleted")
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
    
    //MARK: - IN SUCCESSFULL MESSAGE VIEW
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



///
