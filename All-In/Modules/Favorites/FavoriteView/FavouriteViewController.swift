//
//  FavouriteViewController.swift
//  All-In
//
//  Created by Mahmoud Saad on 04/07/2022.
//

import UIKit

class FavouriteViewController: UIViewController {

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
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let FavouriteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCollectionViewCell
        
        FavouriteCell.FavouriteImage.image = UIImage(named: "bag")
        FavouriteCell.FavouriteLable.text = "Bag"
        FavouriteCell.FavouriteView.layer.cornerRadius = 20
        
        return FavouriteCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200 , height:200)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 2, bottom: 1, right: 2)
        }
    
    
}
