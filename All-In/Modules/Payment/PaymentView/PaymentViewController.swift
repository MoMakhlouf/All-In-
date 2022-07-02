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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.layer.cornerRadius = 15
        
        subTotalPriceLabel.text = "Sub Total : \(subtotal)"
        
        
    }
    
    
    @IBAction func applyCoupon(_ sender: UIButton) {
    
        
    }
    
    


    @IBAction func continueToPaymentButtonPressed(_ sender: Any) {
        let paymentMethod = PaymentMethodsViewController()
        
        navigationController?.pushViewController(paymentMethod, animated: true)
    }
    
}
