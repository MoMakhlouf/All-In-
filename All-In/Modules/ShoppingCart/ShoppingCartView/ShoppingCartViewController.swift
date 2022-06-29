//
//  ShoppingCartViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func ProceedToCheckOut(_ sender: UIButton) {
        let payment = PaymentViewController()
        navigationController?.pushViewController(payment, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
