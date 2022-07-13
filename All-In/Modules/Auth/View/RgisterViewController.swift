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
    
    var registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpbtn.layer.cornerRadius = 15
           
      }


    @IBAction func signUpButton(_ sender: UIButton) {
        
        checkBeforeRegister()
        txtName.text = ""
        txtNameSt.text = ""
        txtEmail1.text = ""
        txtPassword1.text = ""
        txtPhone.text = ""
        let login = LoginViewController()
        navigationController?.pushViewController(login, animated: true)
        
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        let login = LoginViewController()
        navigationController?.pushViewController(login, animated: true)
    }
    
 
}
extension RgisterViewController{
    func checkInfoBeforeRegister()->Bool{
        
        var checkIsSuccess = true
        guard let firstName = txtNameSt.text, let lastName = txtName.text, let email = txtEmail1.text,
              let password = txtPassword1.text, let confirmPassword = txtPhone.text else {return false}
        
        
        self.registerViewModel.checkCustomerInfo(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword) { message in
            
            switch message {
            case "ErrorAllInfoIsNotFound":
                checkIsSuccess = false
                
                self.showAlertError(title: "please fill your infromation to reister", message: "for register must fill all information")
            case "ErrorPassword":
                checkIsSuccess = false
                
                self.showAlertError(title: "There is a problem with the password", message: "please enter password again")
            case "ErrorEmail":
                checkIsSuccess = false
                 
                self.showAlertError(title: "your email is incorrect", message: "please enter correct email")
            default:
                checkIsSuccess = true
            }
        }
        return checkIsSuccess
    }
}
extension RgisterViewController{
    func register(){
        
       
        guard let firstName = txtNameSt.text, let lastName = txtName.text, let email = txtEmail1.text,
              let password = txtPassword1.text else {return}
        
        let customer = Customr(first_name: firstName, email: email, tags: password, id: nil, addresses: nil, lastName: lastName)
        let newCustomer = NewCustomr(customer: customer)
        
        registerViewModel.checkUserIsExist(email: email) { emailIsExist in
            if !emailIsExist{
                self.registerViewModel.createNewCustomer(newCustomer: newCustomer) { data, response, error in
                    
                    guard error == nil else {
                        //register is not success
                         
                        return
                    }
                    //register is success
                    
                    print("register is success")
                }
            }else{
              
                self.showAlertError(title: "your email is already exist", message: "can you login!!")
            }
        }
    }
}
extension RgisterViewController{
    func checkBeforeRegister(){
        if checkInfoBeforeRegister(){
            register()
        }
    }
}

extension RgisterViewController{
    func setupViewWhenShowKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisApear), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func keyboardApear(){
        view.frame.origin.y = 0
        view.frame.origin.y = view.frame.origin.y - 200
    }
    @objc func keyboardDisApear(){
        view.frame.origin.y = 0
    }
}
