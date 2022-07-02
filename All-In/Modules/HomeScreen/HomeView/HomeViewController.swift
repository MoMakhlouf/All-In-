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
    var array = [SmartCollection]()
   var adsPhotos = [UIImage(named: "adidas") , UIImage(named: "nike") , UIImage(named: "timberland") , UIImage(named: "adidas") ,  UIImage(named: "nike")]
    var timer : Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//MARK: - bransHomeCollection
        brandsHomeCollection.dataSource = self
        brandsHomeCollection.delegate = self
        brandsHomeCollection.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "brandCell")
//MARK: - salesCollectionView
        adsCollectionView.dataSource = self
        adsCollectionView.delegate = self
        adsCollectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "adsCell")
        
        startTimer()
//MARK: - brands & Sales border
        brandsView.layer.borderWidth = 1
        brandsView.layer.masksToBounds = true
        brandsView.layer.cornerRadius = 15
        brandsView.layer.borderColor = UIColor.black.cgColor
        brandsView.clipsToBounds = true
        adsView.layer.borderWidth = 1
        adsView.layer.borderColor = UIColor.black.cgColor
        adsView.layer.cornerRadius = 15
       
// MARK: - navigationBar
        
        self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        navigationController?.navigationBar.topItem?.backButtonTitle = " "
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) , .font: UIFont(name: "Helvetica Neue", size: 25.0)!]
       // self.navigationController?.navigationBar.largeContentTitle = "marwa"
        
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
        

        
        if let url = URL(string: "https:// 7d67dd63dc90e18fce08d1f7746e9f41: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@ios-q3-mansoura.myshopify.com/admin/api/2022-01/smart_collections.json"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let jeson = try? jsonDecoder.decode(Collects.self , from: data)
                    self.array = jeson?.smartCollections ?? []
                    DispatchQueue.main.async {
                        self.brandsHomeCollection.reloadData()
                    }
                }
            }.resume()
        }
        
        
    }
    
    
    //MARK: - Timer section for scrollable collectionView
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(nextIndex), userInfo: nil, repeats: true)
        
    }
    
   @objc func nextIndex(){
       if currentCellIndex < adsPhotos.count - 1 {
           currentCellIndex += 1
       } else{
           currentCellIndex = 0
       }
       adsCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
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
            navigationController?.pushViewController(brandsVC, animated: false)
        }
    }
    
}
 
extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollectionView{
            return adsPhotos.count
        }
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollectionView{
            let cell2 = adsCollectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
            
            cell2.adsImage.image = adsPhotos[indexPath.row]
            return cell2
            
        }
        let cell = brandsHomeCollection.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandsCollectionViewCell
        cell.brandName.text = "Adidas"
       // cell.brandImg.sd_setImage(with: URL(string: array[indexPath.row].image.src), placeholderImage: UIImage(named: "placeholder.png"))
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
        
        let shoppingCart = ShoppingCartViewController()
        navigationController?.pushViewController(shoppingCart, animated: true)
        
    }
    
    
    @objc func searchButton(){
        
        
    }
    
    
}
