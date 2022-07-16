//
//  OrdersTableViewCell.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

 
    @IBOutlet weak var nameOfProduct: UILabel!
    

    @IBOutlet weak var priceOfOrder: UILabel!
    
    @IBOutlet weak var imgOfOrder: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgOfOrder.layer.borderWidth = 1
        imgOfOrder.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
