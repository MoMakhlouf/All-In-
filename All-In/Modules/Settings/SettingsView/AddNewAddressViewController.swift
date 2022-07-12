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

          if let url = URL(string: Urls(customerId: "6261211300054").postAddressUrl){
              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
              request.httpShouldHandleCookies = false
              if let httpBody = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) {

                  request.httpBody = httpBody
              }

              let task = URLSession.shared.dataTask(with: request) { data, response, error in

                  if let data = data {
                      do{
                          let json = try JSONSerialization.jsonObject(with: data, options: [])

                          print(json)
                          print("post")
                      }catch {
                          print(error.localizedDescription)
                      }
                  }
              }
              task.resume()
          }
          
      
       //   let addressesList = ListOfAddressesViewController()
         // navigationController?.pushViewController(addressesList, animated: true)
          
          navigationController?.popViewController(animated: true)
          
          countryTextField.text = ""
          cityTextField.text = ""
          governorateTextField.text = ""
          mobileNumberTextField.text = ""
          moreDetailsAddressTextField.text = ""
          
      }
        
    }
    
}
