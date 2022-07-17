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
    var cartItems = [ShoppingCartDB]()

    @IBOutlet weak var Fvritebtn: UIButton!
    var productInfo : Product?
    var FavProduct = [FavouriteDB]()
    var IsAddedfavorite  = false
    let favoriteDB =  DBManager.sharedInstance
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
    var currency = ""
    var usdValue = ""
    var sendPrice = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = view.backgroundColor
     
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        
        CartBtn.layer.cornerRadius = 15

      fetchItem()
      ProductDetailsCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsCell")

         
        //print(FavProduct)
   // ProductDetailsCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailsCell")
        if currency == "USD" {
            let price = Double((productInfo?.variants[0].price)!)
            ProducrPrice1.text =  String(format: "%0.2f", price!) + " USD"
             
        }else{
            let egpPrice = Double((productInfo?.variants[0].price)!)! * Double(usdValue)!
            ProducrPrice1.text =  String(format: "%0.2f", egpPrice) + " EGP"
        }
        ProductName1.text = productInfo?.title
        ProductPageControl.numberOfPages = (productInfo?.images.count)!
        ProductDiscription.text = productInfo?.body_html
       
        let price = Double((productInfo?.variants[0].price)!)
        sendPrice = String(price!)
        print("send price is : \(sendPrice)")

        
       
        startTimer()
        cartedItems()
        favoriteItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItem()
        print(cartItems.count)
        print(cartItems)
        fetchproduct()
        favoriteItem()
         
    }
    
    
    func cartedItems(){
        for item in cartItems {
            if item.itemId == productInfo!.id{
               isAddedToCart = true
                
            }
        }
    }
    
    func favoriteItem()
    {
        for item in FavProduct
        {
            if item.productName == productInfo?.title{
                IsAddedfavorite = true
                 
                Fvritebtn.imageView?.image =
                UIImage(systemName: "heart.fill")
                
            }
         
        }
    }
    
    
    func fetchItem(){
        cartItems = cartDB.getItemToCart(appDelegate: appSelegate)
    }
    func fetchproduct()
    {
        FavProduct = favoriteDB.fetchData(appDelegate: appSelegate)
    }
    
    func goToLoginPage(){
        let loginVC = LoginViewController()
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

    @IBAction func AddToCartBtn(_ sender: UIButton) {
        
        
        UserDefault.shared.checkUserIsLogged { [self] userLogged in
            if userLogged{
              
                if isAddedToCart {
               
                    let alert = UIAlertController(title: "This item is already in cart", message: "Check your cart?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Show cart", style: .default, handler: { [self] UIAlertAction in
                        
                        Fvritebtn.imageView?.image =
                        UIImage(systemName: "heart.fill")
                        
                        let cart = ShoppingCartViewController()
                        navigationController?.pushViewController(cart, animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                } else{
                    // if customer id = db id
                    let itemImage = self.productInfo?.image.src
                    cartDB.saveItemToDB(appDelegate: appSelegate, title: ProductName1.text!, itemQuantity: 1 , price: sendPrice , itemImage: itemImage ?? "" , itemId: Int64(productInfo!.id) , customerId: Int64(UserDefault.shared.getUserID()!))
                    
              
                    print(UserDefault.shared.getUserID())
                  //  6261211300054
                  
                        let cart = ShoppingCartViewController()
                        navigationController?.pushViewController(cart, animated: true)
                    
               
                    
                      isAddedToCart = true
                }
            }else{
                self.goToLoginPage()
                
            }
        }
        
}
    
    @IBAction func FavouriteProductDetailsBtn(_ sender: UIButton) {
        UserDefault.shared.checkUserIsLogged { [self] userLogged in
            if userLogged{
                if IsAddedfavorite{
                    
                    let alert = UIAlertController(title: "This product is already in Favorite", message: "Check your Favorite", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Show Favorite", style: .default, handler: { [self] UIAlertAction in
                
                        Fvritebtn.imageView?.image =
                        UIImage(systemName: "heart.fill")
                        
                        let favorites = FavoriteViewController()
                        navigationController?.pushViewController(favorites, animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
        
                }else{
                    
                    sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                   
                    let  Img = self.productInfo?.image.src
                    favoriteDB.addProduct(productName: ProductName1.text ?? "", productImage:  Img ?? "", productPrice: sendPrice, productDescription: ProductDiscription.text ?? "", productId:  Int64(productInfo!.id)
                      , customerId: Int64(UserDefault.shared.getUserID()!), appDelegate: appSelegate)
                    
                     print( "ProductID : \(productInfo!.id)")
                    
                    print(UserDefault.shared.getUserID())
                    
//                    let favorites = FavoriteViewController()
//                    navigationController?.pushViewController(favorites, animated: true)
                    
                    IsAddedfavorite = true
                }
            }else{
                self.goToLoginPage()
                
            }
        }
    
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
