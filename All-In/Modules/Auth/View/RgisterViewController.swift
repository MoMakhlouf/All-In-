//
//  RgisterViewController.swift
//  All-In
//
//  Created by Mahmoud Saad on 01/07/2022.
//

import UIKit

class RgisterViewController: UIViewController {
    
    let network = NetworkManager()
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var txtNameSt: UITextField!
    
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtEmail1: UITextField!
    
   
    @IBOutlet weak var txtPassword1: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var signUpbtn: UIButton!
    
    @IBOutlet weak var haveAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpbtn.layer.cornerRadius = 15
           
      }


    @IBAction func signUpButton(_ sender: UIButton) {
        
        let customer = NewCustomr(customer: Customr(first_name: txtNameSt.text, email:txtEmail1.text, tags: txtPassword1.text, id: nil, addresses: nil, lastName: txtName.text))
        self.network.registerCustomer(newCustomer: customer) {data , error in
            if let data = data {
                print(data)
            }
        }
        
        
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
    }
    
//    func textFieldSetup(textfield:UITextField , Image:UIImage)
//    {
//        let leftImg = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:  Image.size.width, height:  Image.size.height))
//        leftImg.image = Image
//        textfield.leftView = leftImg
//        textfield.leftViewMode = .always
//    }

}
  

