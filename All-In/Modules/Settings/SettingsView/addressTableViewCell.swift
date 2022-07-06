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

        // Configure the view for the selected state
    }
    
    func getFullAddress(address : Address){
        
        fullAddress.text =  "\(address.country ?? ""), \(address.province ?? ""), \(address.city ?? ""), \(address.address1 ?? "") ,\(address.phone ?? "")"
        fullName.text = "\(address.first_name ?? "") \(address.last_name ?? "")"
    }
    
    func cellSelected() {
     didSelectCell?()
    }
    
    
}
