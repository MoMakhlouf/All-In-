//
//  BrandsCollectionViewCell.swift
//  All-In
//
//  Created by Marwa on 29/06/2022.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var brandImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.brandImg.layer.borderWidth = 1
       // self.brandImg.layer.masksToBounds = true
        self.brandImg.layer.borderColor = UIColor.black.cgColor
        self.brandImg.layer.cornerRadius = 20
        self.brandName.layer.cornerRadius = 20
        //self.brandImg.clipsToBounds = true
        
    }
    
    

}
