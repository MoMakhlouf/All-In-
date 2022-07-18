//
//  AddNewAddressViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class AddNewAddressViewController: UIViewController {
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var governorateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var moreDetailsAddressTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var addNewAddressButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Address"
        addNewAddressButton.layer.cornerRadius = 15
        
        print("User ID :\(Helper.shared.getUserID())")
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 20.0)!]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.systemGray6

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.white
    }

    @IBAction func addNewAddressButtonPressed(_ sender: UIButton) {
         validData()
    }
    
    func validData() {
      
        if countryTextField.text == "" {
            Alert.displayAlert(title: " ", message: "Please enter your country name")
        }
        
       else if governorateTextField.text == "" {
            Alert.displayAlert(title: " ", message: "Please enter your governorate name  ")
        }
        
       else if cityTextField.text == "" {
            Alert.displayAlert(title: " ", message: "Please enter your city name")
        }

       else if moreDetailsAddressTextField.text == "" {
            Alert.displayAlert(title: " ", message: "Please enter your detailed address  ")
        }

       else if mobileNumberTextField.text == "" {
            Alert.displayAlert(title: " ", message: "Please enter you phone number")
           
        }
        
      else if mobileNumberTextField.text!.count != 11 || mobileNumberTextField.text!.prefix(2) != "01"{
            Alert.displayAlert(title: "", message: "Please enter a correct phone number format ")
            return
      } else {
          
          let jsonResponse : [String: [String : Any]] = ["address":
                                                          ["address1": moreDetailsAddressTextField.text!,"city": cityTextField.text!,"phone": mobileNumberTextField.text!,"province": governorateTextField.text! ,"country":countryTextField.text!,"zip":""]]
             
          print("user id : \(Helper.shared.getUserID())")

          if let url = URL(string: Urls(customerId: Helper.shared.getUserID()!).postAddressUrl){
              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
              request.httpShouldHandleCookies = false
              if let httpBody = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) {

                  request.httpBody = httpBody
              }
              
              let task = URLSession.shared.dataTask(with: request) { data, response, error in

                  print("Address Data :\(data)")
                  if let data = data {
                      do{
                          let json = try JSONSerialization.jsonObject(with: data, options: [])

                          if let dictionary = json as? [String: Any] {
                              if let error = dictionary["errors"]{
                                  print("123\(error)")
                                  DispatchQueue.main.async {
                                      Alert.displayAlert(title: "Wrong country or governorate name ", message: "Please, Add a true address")
                                  }
                              }else{
                                  DispatchQueue.main.async {
                                      self.navigationController?.popViewController(animated: true)
                                      print(json)
                                      print("post")
                                      self.countryTextField.text = ""
                                      self.cityTextField.text = ""
                                      self.governorateTextField.text = ""
                                      self.mobileNumberTextField.text = ""
                                      self.moreDetailsAddressTextField.text = ""
                                  }
                              }
                          }
                        
                         
                      }catch {
                          print(error.localizedDescription)
                          DispatchQueue.main.async {
                              Alert.displayAlert(title: "Wrong Address Format", message: "Write a true address")
                          }
                      }
                  }
              }
              task.resume()
          }
      }
        
    }
    
}
