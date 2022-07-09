//
//  ProductInfoViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit
//import Kingfisher
class ProductInfoViewController: UIViewController {
    
var CurrentCellIndex = 0
    
    @IBOutlet weak var ProductDetailsCollection: UICollectionView!
    {
        didSet {
            ProductDetailsCollection.delegate   = self
            ProductDetailsCollection.dataSource = self
        }
    }
    
    
    @IBOutlet weak var ProductPageControl: UIPageControl!
    
    
    
    @IBOutlet weak var ProductName1: UILabel!
    
    
    @IBOutlet weak var ProducrPrice1: UILabel!
    
    
    
    @IBOutlet weak var Description1: UILabel!
    
    @IBOutlet weak var ProductDiscription: UILabel!
    
    
    @IBOutlet weak var Reviews: UILabel!
    
    
    @IBOutlet weak var lblMahmoud: UILabel!
    
    
    @IBOutlet weak var MahmoudRevirew: UILabel!
    
    

    @IBOutlet weak var CartBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CartBtn.layer.cornerRadius = 15

    ProductDetailsCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsCell")
        ProductPageControl.numberOfPages = 4
        
    }

    @IBAction func AddToCartBtn(_ sender: UIButton) {
    }
    
    @IBAction func FavouriteProductDetailsBtn(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
}
extension ProductInfoViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCell", for: indexPath) as! ProductCollectionViewCell
        ProductCell.ProductDetailsImg.image = UIImage(named: "Bag")
        return ProductCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height:collectionView.frame.height)
        }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
 
    @objc func moveToNextIndex()
    {
        if CurrentCellIndex < 4
        {
            CurrentCellIndex  += 1

        }else{
            CurrentCellIndex   = 1

        }
        ProductDetailsCollection.scrollToItem(at: IndexPath(item: CurrentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        ProductPageControl.currentPage = CurrentCellIndex
    }
    
    
}
