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
    

    var currency = ""
    var usdValue = ""
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        
        
    }
    
    
    func favoriteCellItems( favorite : FavouriteDB){
        faveName.text = favorite.productName
        print(favorite.productPrice)
        if currency == "USD"{
            favePrice.text = favorite.productPrice! + " USD"
        }else{
            let price =  Double(favorite.productPrice!)! * Double(usdValue)!
            favePrice.text =  String(format: "%.2f",  price) + " EGP"
        }
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
