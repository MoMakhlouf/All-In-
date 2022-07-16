//
//  ProductTypeTableViewCell.swift
//  All-In
//
//  Created by Marwa on 11/07/2022.
//

import UIKit

class ProductTypeTableViewCell: UITableViewCell {
    var productType: (()->())?
    @IBOutlet weak var productTypeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkMarkBtn(_ sender: Any) {
        
      //  UITableViewCell.AccessoryType.checkmark
        productType?()
    }
}
