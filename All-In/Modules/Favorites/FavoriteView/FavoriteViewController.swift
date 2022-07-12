//
//  FavoriteViewController.swift
//  All-In
//
//  Created by Mahmoud Saad on 11/07/2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    var fave = [FavouriteDB]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var FavoriteTable: UITableView!
    {
        didSet{
            FavoriteTable.delegate = self
            FavoriteTable.dataSource = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteTable.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        
    }


   

}

extension FavoriteViewController :UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fave.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FavoriteCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as!FavoriteTableViewCell
        FavoriteCell.faveName.text = fave[indexPath.row].productName
        FavoriteCell.favePrice.text = fave[indexPath.row].productPrice
        FavoriteCell.FavImg.loadFromFave(URLAddress: fave[indexPath.row].productImage!)
        return FavoriteCell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fet = DBManager.sharedInstance
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        fave = fet.fetchData(appDelegate: appDelegate)
        FavoriteTable.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { [self] Action, view, completionHandler in
            DBManager.sharedInstance.delete(product: fave[indexPath.row], indexPath: indexPath, appDelegate: self.appDelegate, delegate: self)
 
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
   
    
    
}

extension FavoriteViewController:deletionDelegate
{
   
    
    func deleteProductAtIndexPath(indexPath: IndexPath){
       fave.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.FavoriteTable.reloadData()
        }
    }
}

extension UIImageView
{
  func loadFromFave(URLAddress:String)
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
