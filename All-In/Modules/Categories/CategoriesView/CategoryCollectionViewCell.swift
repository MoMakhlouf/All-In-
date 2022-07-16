//
//  CategoryCollectionViewCell.swift
//  All-In
//
//  Created by Marwa on 30/06/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImg: UIImageView!
    
    @IBOutlet weak var favrCategoryBtn: UIButton!
    @IBOutlet weak var categoryPriceLbl: UILabel!
    var favClicked: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryImg.layer.borderWidth = 1
        self.categoryImg.layer.borderColor = UIColor.black.cgColor
        
    }

    @IBAction func favoriteCategoryBtn(_ sender: UIButton) {
       
    }
    
    
    
}
