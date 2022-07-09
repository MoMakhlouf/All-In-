//
//  ItemsCollectionViewCell.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 07/07/2022.
//

import UIKit
import Kingfisher

class ItemsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemView.layer.cornerRadius = 15
        itemView.layer.borderWidth = 0.3
        itemView.layer.borderColor = UIColor.black.cgColor
     //   imageView.layer.borderWidth = 0.3
        //imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 15
        
        
    }
    
    func cartedItems(_ shopping : ShoppingCartDB){
        itemName.text = shopping.title
        itemPrice.text = shopping.price
        itemImage.kf.setImage(with: URL(string: shopping.itemImage ?? ""))
     
    }

}
