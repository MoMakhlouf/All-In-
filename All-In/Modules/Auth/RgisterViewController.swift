//
//  RgisterViewController.swift
//  All-In
//
//  Created by Mahmoud Saad on 01/07/2022.
//

import UIKit

class RgisterViewController: UIViewController {
    
    @IBOutlet weak var signInLabel: UILabel!
    
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtEmail1: UITextField!
    
   
    @IBOutlet weak var txtPassword1: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var signUpbtn: UIButton!
    
    @IBOutlet weak var haveAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpbtn.layer.cornerRadius = 15
        let emailImage = UIImage(named: "mail")
        textFieldSetup(textfield: txtEmail1,  Image: emailImage!)
        let PasswordImage = UIImage(named: "pass")
        textFieldSetup(textfield: txtPassword1,  Image: PasswordImage!)
        let NameImage = UIImage(systemName: "person")
        textFieldSetup(textfield: txtName,  Image: NameImage!)
        let PhoneImage = UIImage(systemName: "phone")
         textFieldSetup(textfield: txtPhone,  Image: PhoneImage!)
      }


    @IBAction func signUpButton(_ sender: UIButton) {
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
    }
    
    func textFieldSetup(textfield:UITextField , Image:UIImage)
    {
        let leftImg = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:  Image.size.width, height:  Image.size.height))
        leftImg.image = Image
        textfield.leftView = leftImg
        textfield.leftViewMode = .always
    }

}
  

