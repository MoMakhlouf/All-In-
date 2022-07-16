//
//  PaymentMethodsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 30/06/2022.
//

import UIKit
import WebKit
import Alamofire
//import Braintree

class PaymentMethodsViewController: UIViewController , ChooseAddressDelegate  {
  
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
    var totalAmount = ""
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    @IBOutlet weak var crediCardButton: UIButton!
///    var braintreeAPIClient:BTAPIClient!
    let authorization = "sandbox_w3d87wk7_hc7cj2xjtg337ffs"
    @IBOutlet weak var creditCardWebView: WKWebView!
    @IBOutlet weak var placeOrderIndicator: UIActivityIndicatorView!
    let userDefaults = UserDefaults()
    @IBOutlet weak var orderPlacedView: UIView!
    var addressesArray = [Address]()
    var address: Address?
    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        orderPlacedView.isHidden = true
        totalAmountLabel.text = "Total: \(totalAmount)"
        placeOrderButton.layer.cornerRadius = 15
        continueShoppingButton.layer.cornerRadius = 15
        hideView()
        placeOrderButton.isEnabled = false
        placeOrderIndicator.hidesWhenStopped = true
        
              //I will change it to becater produced by user defaults from address list
        let addressViewModel = AddressViewModel()
        addressViewModel.getAdderss(customerId: "6277500960982")
        addressViewModel.bindingData = { addresses , error in
            
            if let addresses = addresses{
                self.addressesArray = addresses
                DispatchQueue.main.async {
                    if self.addressesArray.isEmpty == false {
                        let address = self.addressesArray[0]
                        self.addressFullLabel.text = "\(address.country ?? ""), \(address.province ?? ""), \(address.city ?? ""), \(address.address1 ?? "") ,\(address.phone ?? "")"
                    } else{
                        self.addressFullLabel.text = "Please, add new Address"
                        self.placeOrderButton.isEnabled = false
                        self.changeButton.titleLabel?.text = "Add"
                    }
                }
            }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    Alert.displayAlert(title: "Error", message: "Failed To Apply Coupon")
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func payPalCheckout (amount : String){
/**        self.braintreeAPIClient = BTAPIClient(authorization: authorization)
            let payPalDriver = BTPayPalDriver(apiClient: braintreeAPIClient)
            let request = BTPayPalCheckoutRequest(amount: amount)
            request.currencyCode = "USD"
            var err:Error?
           payPalDriver.tokenizePayPalAccount(with: request) { [weak self] (tokenizedPayPalAccount, error) in
            if tokenizedPayPalAccount != nil {
            }else if let error = error {
                err = error
                print("error is \(error)")
            }

            if err == nil{
                print("")
            }*/
       // }
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
       
        payPalCheckout(amount: totalAmount)
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
        addresses.chooseAddressDelegate = self
    }
    
    
    //MARK: - OREDER CONFIRMATION
    @IBAction func placeOrderButtonPressed(_ sender: UIButton) {
        cartItems = cartDB.getItemToCart(appDelegate: appDelegate)
       // self.address = addressesArray[0]
        var jsonResponse = [String : [String : Any]]()
   //     var items = [Items]()
        let item = cartItems[0]
     /*   for item in cartItems{
            var i = Items(id: Int(item.itemId), title: item.title!, price: item.price!, quantity: Int(item.itemQuantity), sku: item.itemImage!)
            items.append(i)
        }*/
            
        jsonResponse = ["order":["email":Helper.shared.getUserEmail() ?? "m@gmail.com","line_items":[["product_id": item.itemId,"title":item.title!,"price": item.price!,"quantity": item.itemQuantity,"sku":item.itemImage!]],"billing_address":["first_name":"m","last_name":"m","address1":"124" ,"phone":"12345","city":"jjj","province":"","country":"egypt","zip":"124"],"customer":["id":Helper.shared.getUserID()]]]
        
        print(jsonResponse)
        if let url = URL(string: Urls().ordersUrl){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpShouldHandleCookies = false
            if let httpBody = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) {
                print("json\(jsonResponse)")
                request.httpBody = httpBody
            }
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    }catch {
                        print("Errorrr\(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
        
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

/*
extension PaymentMethodsViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
            
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
}
*/


///
