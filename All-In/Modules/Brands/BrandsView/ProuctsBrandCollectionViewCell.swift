//
//  ProuctsBrandCollectionViewCell.swift
//  All-In
//
//  Created by Marwa on 05/07/2022.
//

import UIKit

class ProuctsBrandCollectionViewCell: UICollectionViewCell {
    
     
    var favClicked: (()->())?
    var productse:Product?
    @IBOutlet weak var priceProductLbl: UILabel!
    @IBOutlet weak var nameProductLbl: UILabel!
    //@IBOutlet weak var pageControlImage: UIPageControl!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var prouctImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     //   self.prouctImg.layer.borderWidth = 1
      //  self.prouctImg.layer.borderColor = UIColor.black.cgColor
    }
    
    
  /*  @IBAction func pageControlImage(_ sender: Any) {
    }*/
    
 
    @IBAction func FavoriteBtnPressed(_ sender: UIButton) {
        favClicked?()
    
    }
    
}
 
 
//        Helper.shared.checkUserIsLogged { [self] userLogged in
//            if userLogged{
//         sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        let db = DBManager.sharedInstance
//                let  Img = productInfo?.image.src
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                db.addProduct(productName: nameProductLbl.text ?? "", productImage: Img ?? "", productPrice: priceProductLbl.text ?? "", productDescription: "goofd" , appDelegate: appDelegate)
//
//            }else{
//                goToLoginPage()
//            }
//            func goToLoginPage(){
//                let login = LoginViewController()
//                self.navigationController?.pushViewController(login, animated: true)
//            }
//        }
//
