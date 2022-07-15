//
//  addressTableViewCell.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class addressTableViewCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var fullAddress: UILabel!
    @IBOutlet weak var addressView: UIView!
    
    var didSelectCell : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressView.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        }else{
            addressView.layer.borderWidth = 0

        }
    }
    
    func getFullAddress(address : Address){
        
        fullAddress.text =  "\(address.country ?? ""), \(address.province ?? ""), \(address.city ?? ""), \(address.address1 ?? "") ,\(address.phone ?? "")"
        fullName.text = "\(address.first_name ?? "") \(address.last_name ?? "")"
    
       
    }
    
    func cellSelected() {
     didSelectCell?()
    }
    
    
}
