//
//  CategoriesViewController.swift
//  All-In
//
//  Created by Marwa on 30/06/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    var filterName = ""
    var filterNumber = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        categoriesCollection.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        //segmentedControl()
        

        
    }


    @IBAction func segmentedDidChange(_ sender: Any) {
        filterNumber = segmentedControl.selectedSegmentIndex
        filterName = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? "Man"
      //  array.filter()

        
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
    
}
extension CategoriesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    
        
        
       
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
      
        return cell
    }
    
    
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.3, height: collectionView.frame.width * 0.6)
    }
}
