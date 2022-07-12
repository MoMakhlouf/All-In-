//
//  ProductInfoViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit
import Kingfisher

class ProductInfoViewController: UIViewController {
    
    let cartDB = ShoppingCartDBManager.sharedInstance
    let appSelegate = UIApplication.shared.delegate as! AppDelegate
    var isAddedToCart = false
    var productsArray = [Product]()
    
    var productInfo : Product?
    var FavProduct  : FavouriteDB?
      var Isfavorite  = false

    var CurrentCellIndex = 0
    var timer :Timer?
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
         
        //print(FavProduct)
    ProductDetailsCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsCell")
        
        ProductPageControl.numberOfPages = (productInfo?.images.count)!
        ProductName1.text = productInfo?.title
        ProducrPrice1.text =  "\(productInfo?.variants[0].price ?? "") EGP "
        ProductDiscription.text = productInfo?.body_html
        startTimer()
        
//        for product in productsArray{
//            if product.id == productInfo?.id {
//            isAddedToCart = true
//            CartBtn.isEnabled = false
//            }
//        }
    }
    
    

    @IBAction func AddToCartBtn(_ sender: UIButton) {
        if !isAddedToCart{
        let itemImage = productInfo?.image.src
        cartDB.saveItemToDB(appDelegate: appSelegate, title: ProductName1.text!, itemQuantity: 1 , price: ProducrPrice1.text ?? "", itemImage: itemImage ?? "" , itemId: 0 , customerId: 6261211300054)
        
        let cart = ShoppingCartViewController()
        navigationController?.pushViewController(cart, animated: true)
    }
}
    
    @IBAction func FavouriteProductDetailsBtn(_ sender: UIButton) {
         
         sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        let db = DBManager.sharedInstance
        let  Img = productInfo?.image.src
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        db.addProduct(productName: ProductName1.text ?? "", productImage: Img ?? "", productPrice: ProducrPrice1.text ?? "", productDescription: ProductDiscription.text ?? "", appDelegate: appDelegate)
        
            
        }
    
}
extension ProductInfoViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return (productInfo?.images.count)!
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            
        let ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCell", for: indexPath) as! ProductCollectionViewCell
        ProductCell.ProductDetailsImg.kf.setImage(with: URL(string: productInfo?.images[indexPath.row].src ?? ""))
        
        return ProductCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height:collectionView.frame.height)
        }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
 
    @objc func moveToNextIndex()
    {
        if CurrentCellIndex < (productInfo?.images.count)!   - 1
        {
            CurrentCellIndex  += 1

        }else{
            CurrentCellIndex   = 0

        }
        ProductDetailsCollection.scrollToItem(at: IndexPath(item: CurrentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        ProductPageControl.currentPage = CurrentCellIndex
    }
    
    
}
