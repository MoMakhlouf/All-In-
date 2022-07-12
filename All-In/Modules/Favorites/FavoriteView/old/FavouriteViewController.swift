//
//  FavouriteViewController.swift
//  All-In
//
//  Created by Mahmoud Saad on 04/07/2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    var fave = [FavouriteDB]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    

    @IBOutlet weak var FavouriteCollection: UICollectionView!
    {
        didSet{
            FavouriteCollection.delegate   = self
            FavouriteCollection.dataSource = self
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
        FavouriteCollection.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCell")    }
   

}
extension FavouriteViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fave.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let FavouriteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCollectionViewCell
        
        FavouriteCell.FavouriteImage.loadFrom(URLAddress: fave[indexPath.row].productImage!)
        FavouriteCell.FavouriteLable.text = fave[indexPath.row].productName
          FavouriteCell.FavouriteView.layer.cornerRadius = 20
        
        
        return FavouriteCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: 180, height:190)
        }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 2, bottom: 1, right: 2)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        let fet = DBManager.sharedInstance
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        fave = fet.fetchData(appDelegate: appDelegate)
        FavouriteCollection.reloadData()
    }
    
    
}
extension FavouriteViewController:deletionDelegate
{
   
    
    func deleteProductAtIndexPath(indexPath: IndexPath){
       fave.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.FavouriteCollection.reloadData()
        }
    }
}

extension UIImageView
{
  func loadFrom(URLAddress:String)
   {
      guard let url = URL(string: URLAddress) else{
          return
      }
       DispatchQueue.main.async {[weak self] in
           if let imageData = try?Data(contentsOf: url){
               if let loadImage = UIImage(data: imageData){
                   self?.image = loadImage
               }
           }
       }
  }
}
