//
//  ProuctsBrandCollectionViewCell.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import UIKit

class ProuctsBrandCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var priceProductLbl: UILabel!
    @IBOutlet weak var nameProductLbl: UILabel!
    @IBOutlet weak var pageControlImage: UIPageControl!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var prouctImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func pageControlImage(_ sender: Any) {
    }
    
    @IBAction func favouriteBtn(_ sender: Any) {
    }
}
