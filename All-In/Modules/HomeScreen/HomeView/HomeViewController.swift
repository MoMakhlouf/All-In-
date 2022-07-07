//
//  HomeViewController.swift
//  All-In
//
//  Created by Marwa on 29/06/2022.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var brandsHomeCollection: UICollectionView!
    
    @IBOutlet weak var brandsView: UIView!
    
    @IBOutlet weak var adsCollectionView: UICollectionView!
    @IBOutlet weak var adsView: UIView!
    var brandsArray = [SmartCollection]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
//MARK:- bransHomeCollection
        brandsHomeCollection.dataSource = self
        brandsHomeCollection.delegate = self
        brandsHomeCollection.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "brandCell")
//MARK:- salesCollectionView
        adsCollectionView.dataSource = self
        adsCollectionView.delegate = self
        adsCollectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "adsCell")
//MARK:- brands & Sales border
        brandsView.layer.borderWidth = 1
        brandsView.layer.masksToBounds = true
        brandsView.layer.cornerRadius = 15
        brandsView.layer.borderColor = UIColor.black.cgColor
        brandsView.clipsToBounds = true
        adsView.layer.borderWidth = 1
        adsView.layer.borderColor = UIColor.black.cgColor
        adsView.layer.cornerRadius = 15
       
// MARK:- navigationBar
        
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        navigationController?.navigationBar.topItem?.backButtonTitle = " "
        self.navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 25.0)!]
        
        tabBarController?.tabBarController?.hidesBottomBarWhenPushed = true
        title = "Home"
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
        
        
      
        
     //   self.navigationController?.navigationBar.largeTitleTextAttributes =
        
        let homeViewModel = HomeViewModel()
        homeViewModel.fetchData()
        homeViewModel.bindingData = { brands , error in
            if let brands = brands{
                self.brandsArray = brands.smart_collections
                DispatchQueue.main.async {
                    self.brandsHomeCollection.reloadData()
                }
            }
            if let error = error{
                print(error.localizedDescription)
            }
        }
     
    }

    

    
    override func viewWillAppear(_ animated: Bool) {
       // navigationController?.setNavigationBarHidden(true, animated: true)
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

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == brandsHomeCollection{
            let brandsVC = BrandsViewController()
            brandsVC.brandName = brandsArray[indexPath.row].title
            navigationController?.pushViewController(brandsVC, animated: true)
        }
    }
}
 
extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollectionView{
            return 5
        }
        
        return brandsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollectionView{
            let cell2 = adsCollectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
            return cell2
            
        }
        let cell = brandsHomeCollection.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandsCollectionViewCell
        cell.brandName.text = brandsArray[indexPath.row].title
        cell.brandImg.sd_setImage(with: URL(string: brandsArray[indexPath.row].image.src), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
        
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == brandsHomeCollection{
            return CGSize(width: collectionView.frame.width , height: collectionView.frame.height * 0.5)
        }
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
}

extension HomeViewController{
    @objc func favoriteButton(){
        
    }
    
    @objc func shoppingBagButton(){
        
        
    }
    
    
    @objc func searchButton(){
        
        
    }
    
    
}
