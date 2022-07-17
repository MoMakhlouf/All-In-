//
//  CategoriesViewController.swift
//  All-In
//
//  Created by Marwa on 30/06/2022.
//

import UIKit
import Kingfisher
import Floaty

class CategoriesViewController: UIViewController , UISearchBarDelegate {
  
    let searchProduct = UISearchController(searchResultsController: nil)
    var array: Array<Int> = []
    var productsArray = [Product]()
    var collectsArray = [Collect]()
    var customCollectionsArray = [CustomCollection]()
    var menArray = [Product]()
    var womenArray: [String] = []
    var kidArray : [String] = []
    var arrayProduct = [Product]()
    var filterdProduct = [Product]()

    
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var filterBtn: Floaty!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var categoriesCollection: UICollectionView!

    var currency = ""
    var usdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        categoriesCollection.reloadData()
        
        filterdProduct = menArray
        initSearchController()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 20.0)!]
        
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)

        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        categoriesCollection.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
       
       
      //  categoriesCollection.register(UINib(nibName: "ProuctsBrandCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "productsBrandCell")
        // MARK: - navigationBar
        
        title = "Categories"
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        navigationController?.navigationBar.topItem?.backButtonTitle = " "
      
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 25.0)!]

        let favoriteBtn = UIBarButtonItem()
        favoriteBtn.image = UIImage(systemName: "heart.fill")
        favoriteBtn.action = #selector(favoriteButton)
        favoriteBtn.target = self
         
        let shoppingBagBtn = UIBarButtonItem()
        shoppingBagBtn.image = UIImage(systemName: "bag.fill")
        shoppingBagBtn.action = #selector(shoppingBagButton)
        shoppingBagBtn.target = self
        navigationItem.rightBarButtonItems = [favoriteBtn, shoppingBagBtn]
        

        let productsViewModel = BrandsViewModel()
        productsViewModel.fetchData()
        productsViewModel.bindingData = {products , error in
            if let products = products{
                self.productsArray = products.products
                self.fetchProduct(xx: "MEN")
                
                //self.menArray = products.products
                DispatchQueue.main.async {
                    self.categoriesCollection.reloadData()
                    self.emptyProduct()
                    
                }
            }
            if let error = error{
                print(error.localizedDescription)
            }
        }
        let collectsViewModel = CategoriesViewModel()
        collectsViewModel.fetchCollects()
        collectsViewModel.bindingData = { collects , error in
            if let collects = collects{
                self.collectsArray = collects.collects
            }
            if let error = error{
                print(error.localizedDescription)
            }
            
        }
        let categoriesViewModel = CustomCollectionViewModel()
        categoriesViewModel.fetchData()
        categoriesViewModel.bindingData2 = { categories , error in
            if let categories = categories{
                self.customCollectionsArray = categories.custom_collections
            }
            if let error = error{
                print(error.localizedDescription)
            }
        }
       
        emptyProduct()
        getFilter()
    }
    
    func initSearchController()
       {   searchProduct.loadViewIfNeeded()
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
                filterdProduct  = menArray
            }

            for product in menArray
            {
                if product.title.contains(searchText.uppercased())

                {
                    filterdProduct.append(product)

                }
            }
            categoriesCollection.reloadData()
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        categoriesCollection.reloadData()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currency = Defaults.defaults.getCurrency(key: "currency")
        usdValue = Defaults.defaults.getUsdValue(key: "usd")
        categoriesCollection.reloadData()
    }


    @objc func favoriteButton(){
        
        let favorite = FavoriteViewController()
        
        navigationController?.pushViewController(favorite, animated: true)
    }
    
    @objc func shoppingBagButton(){
        let shoppingCart = ShoppingCartViewController()
        navigationController?.pushViewController(shoppingCart, animated: true)
    }
    
    @objc func searchButton(){
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesCollection.reloadData()
    }
    
    @IBAction func segmentedDidChange(_ sender: Any) {
        DispatchQueue.main.async {
            self.array = []
            self.menArray = []
            self.fetchProduct(xx: self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex)!)
            self.categoriesCollection.reloadData()
            self.emptyProduct()
         }
    }
    
  

    // MARK: - Search
    

}

extension CategoriesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfo = ProductInfoViewController()

        productInfo.productInfo = menArray[indexPath.row]

        navigationController?.pushViewController(productInfo, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        if(searchProduct.isActive)

        {
        return filterdProduct.count

        }else{
        return menArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        if(searchProduct.isActive){
        
        categoriesCollection.reloadItems(at: [indexPath])
    
        if currency == "USD" {
        let price: Float = (Float(filterdProduct[indexPath.row].variants[0].price)!)
        cell.categoryPriceLbl.text = String(format: "%0.2f", price) + " USD"
        }else{
            let priceegp: Float = (Float(filterdProduct[indexPath.row].variants[0].price)! * Float(usdValue)!)
            cell.categoryPriceLbl.text =  String(format: "%0.2f",  priceegp) + " EGP"
        }
        cell.categoryImg.kf.setImage(with: URL(string: filterdProduct[indexPath.row].image.src))

        }else{
            categoriesCollection.reloadItems(at: [indexPath])
        
            if currency == "USD" {
            let price: Float = (Float(menArray[indexPath.row].variants[0].price)!)
            cell.categoryPriceLbl.text = String(format: "%0.2f", price) + " USD"
            }else{
                let priceegp: Float = (Float(menArray[indexPath.row].variants[0].price)! * Float(usdValue)!)
                cell.categoryPriceLbl.text =  String(format: "%0.2f",  priceegp) + " EGP"
            }
            cell.categoryImg.kf.setImage(with: URL(string: menArray[indexPath.row].image.src))
        }
        
        return cell

    }
 
    
    
}




extension CategoriesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.5, height: collectionView.frame.height * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension CategoriesViewController{
    func fetchProduct(xx: String){
        for x in customCollectionsArray{
            if x.title == xx{
                for y in collectsArray{
                    if y.collection_id == x.id{
                        self.array.append(y.product_id)
                    }
                }
            }
        }
        for n in productsArray{
            for i in array{
                if i == n.id{
                    self.menArray.append(n)
                }
            }
            self.arrayProduct = self.menArray
        }
    }
    
}

extension CategoriesViewController{
    func emptyProduct(){
        if menArray.isEmpty {
            categoriesCollection.isHidden = true
        }else{
            categoriesCollection.isHidden = false
        }
    }
    
    func getFilter(){
       /* for i in productType{
            print("i=\(i)")
            self.filterBtn.addItem(icon: UIImage(named: i))
        }*/
      
        filterBtn.buttonImage = UIImage(named: "sort")
        filterBtn.buttonColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        filterBtn.openAnimationType = .fade
        
        filterBtn.addItem("Shoes", icon: UIImage(named: "shoe")) { filterBtn in
            self.menArray = self.arrayProduct
            self.menArray = self.menArray.filter { products in
                products.product_type == "SHOES"
            }
            DispatchQueue.main.async {
                self.categoriesCollection.reloadData()
                self.emptyProduct()
            }
                
        }
        filterBtn.addItem("ACCESSORIES", icon: UIImage(named: "ACCESSORIES")) { filterBtn in
            self.menArray = self.arrayProduct
            self.menArray = self.menArray.filter { products in
            products.product_type == "ACCESSORIES"
            }
            self.emptyProduct()
            DispatchQueue.main.async {
            self.categoriesCollection.reloadData()
            }
        }
        filterBtn.addItem("T-SHIRTS", icon: UIImage(named: "T-SHIRTS")) { filterBtn in
            self.menArray = self.arrayProduct
            self.menArray = self.menArray.filter { products in
                products.product_type == "T-SHIRTS"
            }
            self.emptyProduct()
            DispatchQueue.main.async {
                self.categoriesCollection.reloadData()
                self.emptyProduct()
            }
        }
        
        filterBtn.addItem("No Filter", icon: UIImage(named: "delete")) { filterBtn in
            self.menArray = self.arrayProduct
            self.emptyProduct()
            DispatchQueue.main.async {
                self.categoriesCollection.reloadData()
                self.emptyProduct()
            }
        }
    }

}
