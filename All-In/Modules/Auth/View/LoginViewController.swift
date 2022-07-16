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
    
     
 
    let loginViewModel = LoginViewModel()

  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor.systemGray6

        signIn.layer.cornerRadius = 15
        SignUp.layer.cornerRadius = 15
        guard let id = Helper.shared.getUserID() else {return}
        print(" id : \(id)")
    }
    

    @IBAction func signInButton(_ sender: UIButton) {
        
        login()
      
        Helper.shared.checkUserIsLogged { userLogged in
            if userLogged{
                self.goToProfile()
            }else{
                
            }
        }
        
    }
    func goToProfile(){
        
         
        let profile = HomeViewController()
        navigationController?.pushViewController(profile, animated: true)
         
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
        
    @IBAction func SignUpButton(_ sender: UIButton) {
        let reg = RgisterViewController()
        navigationController?.pushViewController(reg, animated: true)
    }
    
}
     
 
    
   

extension LoginViewController{
    func login(){
        
        guard let email = txtEmail.text, !email.isEmpty, let password = txtPassword.text, !password.isEmpty else {
            
            self.showAlertError(title: "please fill your infromation to login", message: "for login must fill all information")
            return
        }
        loginViewModel.checkUserIsLogged(email: email, password: password) { [self] customerLogged in
            
            if customerLogged  != nil {
                print("success to login")
        
                self.showAlertError(title: "Welcome", message: " Welcome \(txtEmail.text ?? "User") ")
                 let profile = ProfileViewController()
                navigationController?.pushViewController(profile, animated: true)
        

            }else{
                Helper.shared.setUserStatus(userIsLogged: false)
                self.showAlertError(title: "failed to login", message: "please check your email or password")
                print("failed to login")
            }
        }
    }
}
extension LoginViewController{
    func setupViewWhenShowKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisApear), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func keyboardApear(){
        view.frame.origin.y = 0
        view.frame.origin.y = view.frame.origin.y - 170
    }
    @objc func keyboardDisApear(){
        view.frame.origin.y = 0
    }
}
