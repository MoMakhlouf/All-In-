//
//  ListOfAddressesViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class ListOfAddressesViewController: UIViewController {

    @IBOutlet weak var addressTableView: UITableView!{
        didSet{
            addressTableView.delegate   = self
            addressTableView.dataSource = self
            addressTableView.register(UINib(nibName: "addressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
            addressTableView.rowHeight = 130
        }
    }
    
    @IBOutlet weak var addNewAddressButton: UIButton!{
        didSet{
            addNewAddressButton.layer.cornerRadius = 15
        }
    }
    var addressesArray = [Address]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addressViewModel = AddressViewModel()
        addressViewModel.getAdderss(customerId: "6261211300054")
        addressViewModel.bindingData = { addresses , error in
            
            if let addresses = addresses{
                self.addressesArray = addresses
            }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    Alert.displayAlert(title: "Error", message: "Failed To Apply Coupon")
                }
            }
            
        }

        
        

    }


    @IBAction func addNewAddressButtonPressed(_ sender: UIButton) {
        
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
        
    }
    

}


extension ListOfAddressesViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addressTableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! addressTableViewCell
        
        cell.fullAddress.text = addressesArray[indexPath.row].address1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
    
    
    
}
