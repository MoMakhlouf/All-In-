//
//  CategoriesViewController.swift
//  All-In
//
//  Created by Marwa on 30/06/2022.
//

import UIKit
import Kingfisher

class CategoriesViewController: UIViewController {
    var array: Array<Int> = []
    var productsArray = [Product]()
    var collectsArray = [Collect]()
    var customCollectionsArray = [CustomCollection]()
    var menArray = [Product]()
    var womenArray: [String] = []
    var kidArray : [String] = []

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var categoriesCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        categoriesCollection.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
        // MARK: - navigationBar
        
        title = "Categories"
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        navigationController?.navigationBar.topItem?.backButtonTitle = " "
        self.navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
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
        
        let searchBtn = UIBarButtonItem()
        searchBtn.image = UIImage(systemName: "magnifyingglass")
        searchBtn.action = #selector(searchButton)
        searchBtn.target = self
        navigationItem.leftBarButtonItem = searchBtn
        
        
        
        
        let productsViewModel = BrandsViewModel()
        productsViewModel.fetchData()
        productsViewModel.bindingData = {products , error in
            if let products = products{
                self.productsArray = products.products
                self.menArray = products.products
                DispatchQueue.main.async {
                    self.categoriesCollection.reloadData()
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
    }
    
    
    @objc func favoriteButton(){
        
        let favorite = FavouriteViewController()
        
        navigationController?.pushViewController(favorite, animated: true)
        
    }
    
    @objc func shoppingBagButton(){
        
        let shoppingCart = ShoppingCartViewController()
        navigationController?.pushViewController(shoppingCart, animated: true)
        
    }
    
    @objc func searchButton(){
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
   
    }
    
    @IBAction func segmentedDidChange(_ sender: Any) {
       DispatchQueue.main.async {
           self.array = []
           self.menArray = []
           self.fetchProduct(xx: self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex)!)
           self.categoriesCollection.reloadData()
            
        }
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

extension CategoriesViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productInfo = ProductInfoViewController()
        navigationController?.pushViewController(productInfo, animated: true)
        
    }
    
}
extension CategoriesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  /*      if segmentedControl.selectedSegmentIndex == 0{
            return collectsArray.count
       
        }
        
        if segmentedControl.selectedSegmentIndex == 1{
            return customCollectionsArray.count
        }*/
       
        return menArray.count//customCollectionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
       
        let price: Float = (Float(menArray[indexPath.row].variants[0].price)! * 20.0)
        cell.categoryPriceLbl.text = String(price) + " EGP"
        cell.categoryImg.kf.setImage(with: URL(string: menArray[indexPath.row].image.src))
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
           // print(n.id)
            for i in array{
                if i == n.id{
                    self.menArray.append(n)
                }
            }
        }
    }
    
}
