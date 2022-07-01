//
//  PaymentMethodsViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 30/06/2022.
//

import UIKit

class PaymentMethodsViewController: UIViewController {
    @IBOutlet weak var viewIsHiddenConstraints: NSLayoutConstraint!
    @IBOutlet weak var viewIsVisibleConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var crediCardDetailsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        placeOrderButton.layer.cornerRadius = 15
       hideView()
        // Do any additional setup after loading the view.
    }

    @IBAction func cashOnDeliveryButton(_ sender: UIButton) {
        hideView()
    }
    
    @IBAction func creditCardButton(_ sender: UIButton) {
        showView()
    }
    
    
    
    @IBAction func placeOrderButtonPressed(_ sender: UIButton) {
        
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
