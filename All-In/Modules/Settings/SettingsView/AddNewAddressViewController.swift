//
//  AddNewAddressViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class AddNewAddressViewController: UIViewController {
    @IBOutlet weak var governorateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var moreDetailsAddressTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var addNewAddressButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Address"
        addNewAddressButton.layer.cornerRadius = 15
        

        // Do any additional setup after loading the view.
    }

    @IBAction func addNewAddressButtonPressed(_ sender: UIButton) {
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
