//
//  BrandsViewController.swift
//  All-In
//
//  Created by Marwa on 30/06/2022.
//

import UIKit
import Kingfisher

class BrandsViewController: UIViewController ,UISearchBarDelegate {
    

    let searchProduct = UISearchController(searchResultsController: nil)
    @IBOutlet weak var brandSearch: UISearchBar!
    
    var brandName: String?
    var productsArray = [Product]()
    var productsArray2 = [Product]()
    //   var productPriceArray: [String] = []
    var listProduct : [search] = [search]()
    var SearchedProduct : [search] = [search]()
    var searching = false
    var productPriceArray2: [Float] = []
    var productList = [Product]()
    var filterdProduct = [Product]()
    var number: Float = 0.0
    var minumVlaue: Float = 0.0

    @IBOutlet weak var brandsCollectionView: UICollectionView!
        
    
    
    var currency = ""
    var usdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brandSearch.delegate = self
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        
        print("123\(currency)")
        
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        brandsCollectionView.register(UINib(nibName: "ProuctsBrandCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "productsBrandCell")
        self.brandsCollectionView.register(UINib(nibName: "BrandNameCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: "kind2", withReuseIdentifier: "brandNameCell")
         filterdProduct = productsArray
        initSearchController()
 
       filterdProduct = productsArray
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
       // self.tabBarController?.tabBar.isHidden = true
         
//        listProduct.removeAll()
//             for i in 0..<self.filterdProduct.count {
//                 let search = search(name: filterdProduct[i].title, img: filterdProduct[i].image.src, price: filterdProduct[i].variants[0].price)
//                 listProduct.append(search)
//                 brandsCollectionView.reloadData()
//             }
        
        let filterBtn = UIBarButtonItem()
        filterBtn.image = UIImage(systemName: "line.3.horizontal.decrease")
        filterBtn.action = #selector(filterBrands)
        filterBtn.target = self
        navigationItem.rightBarButtonItem = filterBtn
        navigationItem.title = "Brands"
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
    
        
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
        navigationController?.navigationBar.backgroundColor = UIColor.systemGray6
    }
     
    @objc func filterBrands(){
        
        let filterVC = FilterViewController()
        navigationController?.pushViewController(filterVC, animated: true)
        //filterVC.productPriceArray = self.productPriceArray
        filterVC.lastValue = self.minumVlaue
        filterVC.productArray = self.productsArray
        filterVC.convert = self.productPriceArray2
        filterVC.delegate2 = self
        
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        listProduct.removeAll()
//             for i in 0..<self.filterdProduct.count {
//                 let search = search(name: filterdProduct[i].title, img: filterdProduct[i].image.src, price: filterdProduct[i].variants[0].price)
//                 listProduct.append(search)
//                 brandsCollectionView.reloadData()
//             }
//    }
    func initSearchController()
    {
        searchProduct.loadViewIfNeeded()
        searchProduct.obscuresBackgroundDuringPresentation = false
        searchProduct.searchBar.enablesReturnKeyAutomatically = false
        searchProduct.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchProduct
        navigationItem.hidesSearchBarWhenScrolling = false
        searchProduct.searchBar.delegate = self
        searchProduct.searchBar.placeholder = "Search Product By Name"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdProduct = []
        if searchText == ""
        {
            filterdProduct  = productsArray
        }
        for product in productsArray
        {
            if product.title.contains(searchText.uppercased())
            {
                filterdProduct.append(product)
            }
        }
        brandsCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

            searchBar.text = ""
       
        brandsCollectionView.reloadData()

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
        if(searchProduct.isActive)
        {
        return filterdProduct.count
        }else{
        return productsArray.count
        }
     
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: "productsBrandCell", for: indexPath) as! ProuctsBrandCollectionViewCell
        if(searchProduct.isActive)
        {
            cell.nameProductLbl.text = filterdProduct[indexPath.row].title + " - " + filterdProduct[indexPath.row].variants[0].option2
            
            
            if currency == "USD"  {
                let price: Float = (Float(filterdProduct[indexPath.row].variants[0].price)!)
                cell.priceProductLbl.text = String(format: "%.2f", price) + " USD"
            } else{
                let price: Float = (Float(filterdProduct[indexPath.row].variants[0].price)! * (Float(usdValue)!))
                cell.priceProductLbl.text = String(format: "%.2f",  price) + " EGP"
            }
            cell.prouctImg.kf.setImage(with: URL(string: filterdProduct[indexPath.row].image.src))
        }else{
            
            cell.nameProductLbl.text = productsArray[indexPath.row].title + " - " + productsArray[indexPath.row].variants[0].option2
            
            
            if currency == "USD"  {
                let price: Float = (Float(productsArray[indexPath.row].variants[0].price)!)
                cell.priceProductLbl.text = String(format: "%.2f", price) + " USD"
            } else{
                let price: Float = (Float(productsArray[indexPath.row].variants[0].price)! * (Float(usdValue)!))
                cell.priceProductLbl.text = String(format: "%.2f",  price) + " EGP"
            }
            cell.prouctImg.kf.setImage(with: URL(string: productsArray[indexPath.row].image.src))
        }
    
           
        
        
        

        //cell.prouctImg.sd_setImage(with: URL(string: productsArray[indexPath.row].image.src), placeholderImage: UIImage(named: "placeholder.png"))
       
        
//        cell.favClicked =
//        {[weak self]in
//            guard let self = self else {return}
//            UserDefault.shared.checkUserIsLogged { [self] userLogged in
//                       if userLogged{
//                           cell.favouriteBtn.imageView?.image
//                           = UIImage(named: "plus")
//                   let db = DBManager.sharedInstance
//                           let  Img =  self.productsArray[indexPath.row].image.src
//                   let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                           db.addProduct(productName: cell.nameProductLbl.text ?? "", productImage: Img , productPrice:self.productsArray[indexPath.row].variants[0].price ,  productDescription: "" , appDelegate: appDelegate)
//
//                       }else{
//                           goToLoginPage()
//                       }
//                       func goToLoginPage(){
//                           let login = LoginViewController()
//                           self.navigationController?.pushViewController(login, animated: true)
//                       }
//                   }
//        }
//
        
        
       
        
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
        return CGSize(width: collectionView.frame.width * 0.48 , height: collectionView.frame.height * 0.6)
    }
  /* func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       let header = brandsCollectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: "brandNameCell", for: indexPath) as! BrandNameCollectionReusableView
        header.brandNameLbl.text = "Adidas" //productsArray[indexPath.row].title + "Brand"        
        return header
    }*/
}

extension BrandsViewController: delegateFilter{
    func filterPrice(minn: Float, maxx: Float) {
        self.minumVlaue = minn
        self.productsArray = self.productsArray2
        self.productsArray = productsArray.filter { products in
            Float(products.variants[0].price)! * 20 >= minn
        }
        DispatchQueue.main.async {
            self.brandsCollectionView.reloadData()
        }
    }
}
 
 
//extension BrandsViewController : UISearchBarDelegate
//{
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty
//        {
//            listProduct.removeAll()
//            listProduct = SearchedProduct
//        }else {
//            listProduct.removeAll()
//                        for product in SearchedProduct {
//                            if (product.searchTitle!.contains(searchText)) {
//                                listProduct.append(product)
//                            }
//                        }
//        }
//        brandsCollectionView.reloadData()
//    }
//
//
//}
