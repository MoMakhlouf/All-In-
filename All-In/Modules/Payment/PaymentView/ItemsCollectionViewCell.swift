//
//  ItemsCollectionViewCell.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 07/07/2022.
//

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        itemView.layer.cornerRadius = 15
        itemView.layer.borderWidth = 0.3
        itemView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 15
        
        
    }

}
