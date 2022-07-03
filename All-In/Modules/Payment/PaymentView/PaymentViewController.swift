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
    
    var subtotal = 0.0
    var discountCodesArray = [Discount_codes]()
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.layer.cornerRadius = 15
        
        subTotalPriceLabel.text = "Sub Total : \(subtotal)"
        
        let discountCodeModel = DiscountCodeViewModel()
        discountCodeModel.getDiscountCode(priceRule: "1191661535446")
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

      //  couponTextField.text = discountCodesArray[1].code
        print(discountCodesArray.count)
    }
    
    @IBAction func applyCoupon(_ sender: UIButton) {
        
        if couponTextField.text == discountCodesArray[0].code  {
            let discountAmount = String(format: "%.2f", subtotal * (5/100))
            let totalAfterDiscount = String(format: "%.2f", subtotal - subtotal * (5/100))
            discountLabel.text = " \(discountAmount) EGP Discount"
            totalPriceAfterDiscountLabel.text = " Total : \(totalAfterDiscount) "
            
            
        } else if couponTextField.text == discountCodesArray[1].code {
        
            let discountAmount = String(format: "%.2f", subtotal * (10/100))
            let totalAfterDiscount = String(format: "%.2f", subtotal - subtotal * (10/100))
            discountLabel.text = " \(discountAmount) EGP Discount"
            totalPriceAfterDiscountLabel.text = " Total : \(totalAfterDiscount) "
        
        }else if couponTextField.text == "" {
            discountLabel.text = " "


            Alert.displayAlert(title: "Enter a coupon", message: "You must enter a valid coupon")
        }else{
            discountLabel.text = " "

            totalPriceAfterDiscountLabel.text = " Total : \(subtotal) "

            Alert.displayAlert(title: "Invalid Coupon", message: "")
        }
        
    }
        

    @IBAction func continueToPaymentButtonPressed(_ sender: Any) {
        let paymentMethod = PaymentMethodsViewController()
        
        navigationController?.pushViewController(paymentMethod, animated: true)
    }
    
}
