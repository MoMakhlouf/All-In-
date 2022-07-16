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

 
//Helper.shared.checkUserIsLogged { [self] userLogged in
//    if userLogged{
// sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//let db = DBManager.sharedInstance
//        let  Img = products?.image.src
//let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        db.addProduct(productName:  "", productImage: Img ?? "", productPrice: categoryPriceLbl.text ?? "", productDescription: "" , appDelegate: appDelegate)
//
//    }else{
//        self.inputViewController?.showAlertError(title: "Error", message: "First,you have to Sign In or Sign Up !!!")
//    }
//
//}
