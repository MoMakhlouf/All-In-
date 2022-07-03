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
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func addNewAddressButtonPressed(_ sender: UIButton) {
        
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
        
    }
    

}


extension ListOfAddressesViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addressTableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! addressTableViewCell
                
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
    
    
    
}
