//
//  addressTableViewCell.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 01/07/2022.
//

import UIKit

class addressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressView.layer.cornerRadius = 15
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
