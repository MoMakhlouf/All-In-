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
    @IBOutlet weak var noAddressView: UIView!
    var addressesArray = [Address]()
    let userDefaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()

        noAddressView.isHidden = true
        
        print(addressesArray.count)
        emptyAddress()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let addressViewModel = AddressViewModel()
        addressViewModel.getAdderss(customerId: UserDefault.shared.getUserID()!)
        addressViewModel.bindingData = { addresses , error in
            
            if let addresses = addresses{
                self.addressesArray = addresses
                DispatchQueue.main.async {
                    self.addressTableView.reloadData()
                    self.emptyAddress()
                }
            }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    Alert.displayAlert(title: "Error", message: "Failed To Apply Coupon")
                }
            }
            
        }
    }
    
    func emptyAddress(){
        if addressesArray.isEmpty {
            noAddressView.isHidden = false
        }else{
            noAddressView.isHidden = true
        }
    }
    
    @IBAction func addNewAddressButtonPressed(_ sender: UIButton) {
        
        let add = AddNewAddressViewController()
        navigationController?.pushViewController(add, animated: true)
    //let setting = SettingsViewController()
    //navigationController?.pushViewController(setting, animated: true)
    
    }
    
}

extension ListOfAddressesViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addressTableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! addressTableViewCell
        cell.selectionStyle = .none
        cell.getFullAddress(address: addressesArray[indexPath.row])
              
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addressesArray[indexPath.row]
       // chooseAddressDelegate?.didSelectAddress(address: "\(address.country ?? ""), \(address.province ?? ""), \(address.city ?? ""), \(address.address1 ?? "") ,\(address.phone ?? "")")
        Defaults.defaults.setAddress(value: "\(address.country ?? ""), \(address.province ?? ""), \(address.city ?? ""), \(address.address1 ?? "") ,\(address.phone ?? "")", key: "address")
           
    }
    
    
    
    //MARK: - DELETE AN ADDRESS
    
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
                print("delete Address")
                let address =  addressesArray[indexPath.row].id
            NetworkManager.shared.deleteAddress(customerID: UserDefault.shared.getUserID()! , addressID: address ?? 0 ) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        print("error")
                        return
                    }
                    if indexPath.row == 0{
                        Alert.displayAlert(title: "", message: "Can't delete the default address")
                    } else{
                        
                        let alert = UIAlertController(title: "Delete Address", message: "Are you want to delete this Address?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] UIAlertAction in
                            
                            print("DELETED")
                            self.addressesArray.remove(at: indexPath.row)
                            self.addressTableView.deleteRows(at: [indexPath], with: .fade)
                        }))
                        self.present(alert, animated: true, completion: nil)
         
                    }
                }
            emptyAddress()

        }
    }

}
