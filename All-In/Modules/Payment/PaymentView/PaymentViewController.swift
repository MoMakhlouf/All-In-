//
//  PaymentViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit

class PaymentViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var subTotalPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalPriceAfterDiscountLabel: UILabel!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var congratsView: UIView!
    @IBOutlet weak var congratsViewLabel: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var itemsCollectionView: UICollectionView!{
        didSet{
            itemsCollectionView.delegate = self
            itemsCollectionView.dataSource = self
            itemsCollectionView.register(UINib(nibName: "ItemsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "itemsCell")
        }
    }
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var cartItems = [ShoppingCartDB]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cartDB = ShoppingCartDBManager.sharedInstance
    var finalTotal = ""
    var subtotal = 0.0
    var discountCodesArray = [Discount_codes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        congratsView.isHidden = true
        view.addSubview(congratsView)
        congratsView.center = view.center
        indicatorView.hidesWhenStopped = true
        continueButton.layer.cornerRadius = 15
        
        subTotalPriceLabel.text = "Sub Total : \(subtotal)"
        
        let discountCodeModel = DiscountCodeViewModel()
        discountCodeModel.getDiscountCode()
        discountCodeModel.bindingData = { discounts , error in
            if let discounts = discounts{
                self.discountCodesArray = discounts
            }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    Alert.displayAlert(title: "Error", message: "Failed To Apply Coupon")
                }
            }
        }
        
        totalPriceAfterDiscountLabel.text = " Total : \(subtotal) "
        self.finalTotal = "\(subtotal) "

        print(discountCodesArray.count)
        getItems()
        print(cartItems.count)

    }
    
    //MARK: - Fetch Cart Items from coreData
    func getItems(){
        cartItems = cartDB.getItemToCart(appDelegate: appDelegate)
    }
    
    //MARK: - Discount Code process
    @IBAction func applyCoupon(_ sender: UIButton) {
        
        if couponTextField.text == discountCodesArray[0].code  {
            indicatorView.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 1.5 , repeats: false) { timer in
                self.indicatorView.stopAnimating()
                let discountAmount = String(format: "%.2f", self.subtotal * (5/100))
                let totalAfterDiscount = String(format: "%.2f", self.subtotal - self.subtotal * (5/100))
                self.discountLabel.text = " \(discountAmount) EGP Discount"
                self.applyButton.titleLabel?.text = "\(discountAmount) EGP Discount"
                self.applyButton.isEnabled = false
                self.totalPriceAfterDiscountLabel.text = " Total : \(totalAfterDiscount) "
                self.finalTotal = totalAfterDiscount
            }
            
            congratsView.isHidden = false
            self.congratsViewLabel.text = "You Won a 5% OFF"
            Timer.scheduledTimer(withTimeInterval: 1 , repeats: false) { timer in
                self.congratsView.isHidden = true
            }
            
            } else if couponTextField.text == discountCodesArray[1].code {
            indicatorView.startAnimating()
            Timer.scheduledTimer(withTimeInterval: 1.5 , repeats: false) { timer in
                self.indicatorView.stopAnimating()

                let discountAmount = String(format: "%.2f", self.subtotal * (10/100))
                let totalAfterDiscount = String(format: "%.2f", self.subtotal - self.subtotal * (10/100))
                self.applyButton.titleLabel?.text = "\(discountAmount) EGP Discount"
                self.applyButton.isEnabled = false
                
                self.discountLabel.text = " \(discountAmount) EGP Discount"
                self.totalPriceAfterDiscountLabel.text = " Total : \(totalAfterDiscount) "
                self.finalTotal = totalAfterDiscount

            }
            
            congratsView.isHidden = false
            congratsViewLabel.text = "You Won a 10% OFF"
            Timer.scheduledTimer(withTimeInterval: 1 , repeats: false) { timer in
                self.congratsView.isHidden = true
            }
        }else if couponTextField.text == "" {
            discountLabel.text = " "

            Alert.displayAlert(title: "Enter a coupon", message: "You must enter a valid coupon")
        }else{
            discountLabel.text = " "
  
            totalPriceAfterDiscountLabel.text = " Total : \(subtotal) "
            self.finalTotal = "\(subtotal) "
            
            Alert.displayAlert(title: "Invalid Coupon", message: "")
        }
        
    }
    
        //MARK: - Continue to Checkout..
    @IBAction func continueToPaymentButtonPressed(_ sender: Any) {
        let paymentMethod = PaymentMethodsViewController()
        paymentMethod.totalAmount = finalTotal
        navigationController?.pushViewController(paymentMethod, animated: true)
    }
    
}

//MARK: - Cart Items CollectionView
extension PaymentViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = itemsCollectionView.dequeueReusableCell(withReuseIdentifier: "itemsCell", for: indexPath) as! ItemsCollectionViewCell
        
        cell.cartedItems(cartItems[indexPath.row])
        
        return cell
        
    }
}

extension PaymentViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height )
    }
}
