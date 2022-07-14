//
//  BrandsViewController.swift
//  All-In
//
//  Created by Marwa on 30/06/2022.
//

import UIKit
import Kingfisher

class BrandsViewController: UIViewController{
    
    
    var brandName: String?
    var productsArray = [Product]()
    var productsArray2 = [Product]()
    //   var productPriceArray: [String] = []
    var productPriceArray2: [Float] = []
    var number: Float = 0.0
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    var currency = ""
    var usdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        
        print("123\(currency)")
        
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        brandsCollectionView.register(UINib(nibName: "ProuctsBrandCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "productsBrandCell")
        self.brandsCollectionView.register(UINib(nibName: "BrandNameCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: "kind2", withReuseIdentifier: "brandNameCell")
        
        let filterBtn = UIBarButtonItem()
        filterBtn.image = UIImage(systemName: "line.3.horizontal.decrease")
        filterBtn.action = #selector(filterBrands)
        filterBtn.target = self
        navigationItem.rightBarButtonItem = filterBtn
        navigationItem.title = "Brands"
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
       // navigationController?.isNavigationBarHidden = true
        
        let tabbar = TabBarController()
        tabbar.tabBarController?.tabBarController?.hidesBottomBarWhenPushed = true
        tabbar.navigationController?.navigationBar.isHidden = true
        //tabBarController?.navigationController?.isToolbarHidden = true
        
        let brandsModelView = BrandsViewModel()
        brandsModelView.fetchData()
        brandsModelView.bindingData = {products , error in
            if let products = products{
                for product in products.products{
                    if product.vendor == self.brandName{
                       // self.number = Float(product.variants[0].price)! * 20.0
                        self.productsArray.append(product)
                        self.productsArray2.append(product)
                        self.number = Float(product.variants[0].price)!
                        self.productPriceArray2.append(self.number)
                    }
                }
                DispatchQueue.main.async {
                    self.brandsCollectionView.reloadData()
                }
            }
            if let error = error{
                Alert.displayAlert(title: "Error", message: error.localizedDescription)
                //print(error.localizedDescription)
            }
        }
    }
    
    @objc func filterBrands(){
        
        let filterVC = FilterViewController()
        navigationController?.pushViewController(filterVC, animated: true)
        //filterVC.productPriceArray = self.productPriceArray
        filterVC.productArray = self.productsArray
        filterVC.convert = self.productPriceArray2
        filterVC.delegate2 = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
 
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BrandsViewController: UICollectionViewDelegate{
    
}

extension BrandsViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: "productsBrandCell", for: indexPath) as! ProuctsBrandCollectionViewCell
        cell.nameProductLbl.text = productsArray[indexPath.row].title + " \\" + productsArray[indexPath.row].variants[0].option2
        
        if currency == "USD"  {
            let price: Float = (Float(productsArray[indexPath.row].variants[0].price)!)
            cell.priceProductLbl.text = String(price) + "USD"
        } else{
            let price: Float = (Float(productsArray[indexPath.row].variants[0].price)! * Float(usdValue)!)
            cell.priceProductLbl.text = String(price) + "EGP"
        }
        
        
        //cell.prouctImg.sd_setImage(with: URL(string: productsArray[indexPath.row].image.src), placeholderImage: UIImage(named: "placeholder.png"))
        cell.prouctImg.kf.setImage(with: URL(string: productsArray[indexPath.row].image.src))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetails = ProductInfoViewController()
        productDetails.productInfo = productsArray[indexPath.row]
        navigationController?.pushViewController(productDetails, animated: true)
    }
}



extension BrandsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height * 0.6)
    }
  /* func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       let header = brandsCollectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: "brandNameCell", for: indexPath) as! BrandNameCollectionReusableView
        header.brandNameLbl.text = "Adidas" //productsArray[indexPath.row].title + "Brand"        
        return header
    }*/
}

extension BrandsViewController: delegateFilter{
    func filterPrice(minn: Float, maxx: Float) {
        self.productsArray = self.productsArray2
        self.productsArray = productsArray.filter { products in
            Float(products.variants[0].price)! * 20 >= minn
        }
        DispatchQueue.main.async {
            self.brandsCollectionView.reloadData()
        }
        //self.productsArray = []
   /*     for x in products{
            if Float(x.variants[0].price)! * 20 >= minn && Float(x.variants[0].price)! * 20 <= maxx {
                self.productsArray.append(x)
                DispatchQueue.main.async {
                    self.brandsCollectionView.reloadData()
                }
            }
        }*/
    }
}
