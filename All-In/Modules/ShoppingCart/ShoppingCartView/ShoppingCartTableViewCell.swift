//
//  ShoppingCartTableViewCell.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit
//import Kingfisher

class ShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var shoppingCartCellView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    var didTapPlus: (()->())?
    var didTapMin: (()->())?
    
    var currency = ""
    var usdValue = ""
    
        

    override func awakeFromNib() {
        super.awakeFromNib()
        
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        
        shoppingCartCellView.layer.cornerRadius = 15
        shoppingCartCellView.layer.borderWidth = 0.5
        shoppingCartCellView.layer.borderColor = UIColor.black.cgColor
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          
    }
    
    func itemsInCell(_ item : ShoppingCartDB){
        itemName.text = item.title
        if currency == "USD" {
            itemPrice.text = item.price! + " USD"
        } else{
             let price = Double(item.price!)! * Double(usdValue)!
            itemPrice.text =  String(format: "%.2f",  price)  + " EGP"
            //print("\(price)")
           // itemPrice.text = item.price! + " EGP"

        }
          
        quantityLabel.text = String(item.itemQuantity)
        itemImage.kf.setImage(with: URL(string: item.itemImage ?? ""))
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        didTapMin?()
    }
    
    
    @IBAction func plusButtobPressed(_ sender: Any) {
        didTapPlus?()
    }
    
}
