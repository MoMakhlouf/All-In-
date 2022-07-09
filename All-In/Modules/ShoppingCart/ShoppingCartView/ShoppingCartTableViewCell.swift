//
//  ShoppingCartTableViewCell.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit
import Kingfisher

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
        shoppingCartCellView.layer.borderWidth = 0.5
        shoppingCartCellView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          
    }
    
    func itemsInCell(_ item : ShoppingCartDB){
        itemName.text = item.title
        itemPrice.text = item.price
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
