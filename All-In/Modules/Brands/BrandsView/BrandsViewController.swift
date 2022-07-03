//
//  BrandsViewController.swift
//  All-In
//
//  Created by Marwa on 30/06/2022.
//

import UIKit

class BrandsViewController: UIViewController {

    @IBOutlet weak var brandsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        brandsCollectionView.register(UINib(nibName: "CategoryCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
        let filterBtn = UIBarButtonItem()
        filterBtn.image = UIImage(systemName: "text.chevron.left")
        filterBtn.action = #selector(filterBrands)
        filterBtn.target = self
        navigationItem.rightBarButtonItem = filterBtn
        navigationItem.title = "Brands"
        //navigationController?.isNavigationBarHidden = true
        
        let tabbar = TabBarController()
        tabbar.navigationController?.navigationBar.isHidden = true
        tabbar.navigationItem.title = "Btands"
        //tabBarController?.navigationController?.isToolbarHidden = true
        navigationController?.isToolbarHidden = true
       // tabbar.navigationController?.isToolbarHidden = true
        
    }
    
    @objc func filterBrands(){
        
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
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryPriceLbl.text = "597"
        return cell
    }
}



extension BrandsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.width * 0.5)
    }
}
