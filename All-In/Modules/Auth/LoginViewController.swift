//
//  LoginViewController.swift
//  All-In
//
//  Created by Mahmoud Saad on 01/07/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
     
    @IBOutlet weak var SignLabel: UILabel!
    
 
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var signIn: UIButton!
    
    
 
    @IBOutlet weak var SignUp: UIButton!
    
     
 
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        signIn.layer.cornerRadius = 15
        SignUp.layer.cornerRadius = 15
       // let emailImage = UIImage(named: "mail")
       // textFieldSetup(textfield: txtEmail,  Image: emailImage!)
//        let PasswordImage = UIImage(named: "pass")
//        textFieldSetup(textfield: txtPassword,  Image: PasswordImage!)
    }
    

    @IBAction func signInButton(_ sender: UIButton) {
    }
    
 
    @IBAction func signUpButton(_ sender: UIButton) {
        let register = RgisterViewController()
        navigationController?.pushViewController(register, animated: true)
     
    }
    func textFieldSetup(textfield:UITextField , Image:UIImage)
    {
        let leftImg = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width:  Image.size.width, height:  Image.size.height))
        leftImg.image = Image
        textfield.leftView = leftImg
        textfield.leftViewMode = .always
    }
}
 
