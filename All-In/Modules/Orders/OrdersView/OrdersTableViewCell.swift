//
//  OrdersTableViewCell.swift
//  All-In
//
//  Created by Marwa on 04/07/2022.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfOrder: UILabel!
    
    @IBOutlet weak var dateOfOrder: UILabel!
    
    @IBOutlet weak var imgOfOrder: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
