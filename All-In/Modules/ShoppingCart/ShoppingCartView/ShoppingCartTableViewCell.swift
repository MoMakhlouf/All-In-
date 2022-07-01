//
//  ShoppingCartTableViewCell.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit
import SDWebImage

class ShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var shoppingCartCellView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    var didTapPlus: (()->())?
    var didTapMin: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        shoppingCartCellView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          
    }
    
    func itemsInCell(_ item : ShoppingCartItem){
        itemName.text = item.itemName
        itemPrice.text = String(item.itemPrice)
        quantityLabel.text = String(item.itemQuantity)
        
        itemImage.sd_setImage(with: URL(string: item.itemImage), placeholderImage: UIImage(systemName: "heart"))
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        didTapMin?()
    }
    
    
    @IBAction func plusButtobPressed(_ sender: Any) {
        didTapPlus?()
    }
    
}
