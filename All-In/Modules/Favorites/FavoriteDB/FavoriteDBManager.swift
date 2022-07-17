//
//  FavoriteDBManager.swift
//  All-In
//
//  Created by Mahmoud Saad on 08/07/2022.
//

import Foundation
import CoreData

protocol deletionDelegate{
    func deleteProductAtIndexPath(indexPath: IndexPath)
}

class DBManager{
    static let sharedInstance = DBManager()
    private init(){
        print("Data Base")
    }
}
extension DBManager{


    func addProduct(productName: String, productImage: String,productPrice:String,productDescription:String,productId : Int64 , customerId : Int64,appDelegate: AppDelegate){
        let managedContext = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "FavouriteDB", in: managedContext){
            let product = NSManagedObject(entity: entity, insertInto: managedContext)
            product.setValue(productName, forKey: "productName")
            product.setValue(productImage,forKey: "productImage")
            product.setValue(productPrice,forKey: "productPrice")
            product.setValue(productDescription,forKey:"productDescription")
            product.setValue(productId, forKey: "productId")
            product.setValue(customerId, forKey: "customerId")
            print("Set Data")
            do {
                try managedContext.save()
                print("Save Data Base")
            }catch let error as NSError {
                print("Error in saving")
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData(appDelegate: AppDelegate) -> [FavouriteDB]{

        var fetchedList : [FavouriteDB] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteDB")


        do{
            fetchedList = try managedContext.fetch(fetchRequest) as! [FavouriteDB]
        }catch let error as NSError {
            print("Error in saving")
            print(error.localizedDescription)
        }
        return fetchedList
    }

    func delete(product: FavouriteDB, indexPath: IndexPath, appDelegate: AppDelegate, delegate: deletionDelegate){

        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(product)
        do{
            try managedContext.save()
            delegate.deleteProductAtIndexPath(indexPath: indexPath)
            print("Cell Is Deleted")
        }catch let error as NSError{
            print("Error in saving")
            print(error.localizedDescription)
        }
        
    }
}
