//
//  FavoriteTableViewCell.swift
//  All-In
//
//  Created by Mahmoud Saad on 11/07/2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FavImg: UIImageView!
    
    @IBOutlet weak var faveName: UILabel!
    
    @IBOutlet weak var favePrice: UILabel!
    
    
    
    @IBOutlet weak var FaveView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
