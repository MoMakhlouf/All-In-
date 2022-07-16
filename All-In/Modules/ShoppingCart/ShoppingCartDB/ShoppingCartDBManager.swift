//
//  ShoppingCartDBManager.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 02/07/2022.
//

import Foundation
import CoreData

protocol DeletionDelegate{
    func deleteCartItem(indexPath : IndexPath)
}

class ShoppingCartDBManager{
    static let sharedInstance = ShoppingCartDBManager()
    private init(){}
}

extension ShoppingCartDBManager{
    
    //MARK: - Save Item To Database

    func saveItemToDB( appDelegate : AppDelegate , title : String ,  itemQuantity : Int32 , price : String , itemImage : String , itemId : Int64 , customerId : Int64 ) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "ShoppingCartDB", in: managedContext){
            
            let cartItem = NSManagedObject(entity: entity, insertInto: managedContext)
            cartItem.setValue(title, forKey: "title")
            cartItem.setValue(itemQuantity,forKey: "itemQuantity")
            cartItem.setValue(price, forKey: "price")
            cartItem.setValue(itemId, forKey: "itemId")
            cartItem.setValue(itemImage, forKey: "itemImage")
            cartItem.setValue(customerId, forKey: "customerId")
            do{
            try managedContext.save()
            }catch{
                print("error")
            }
        }

    }

    //MARK: - insert item into cart
    func getItemToCart(appDelegate : AppDelegate) -> [ShoppingCartDB]{
        
        var fetchedList : [ShoppingCartDB] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartDB")
        
//        let predicate = NSPredicate(format: "customerId == %@", Helper.shared.getUserID()!)
//         fetchRequest.predicate = predicate
        do{
            fetchedList = try managedContext.fetch(fetchRequest) as! [ShoppingCartDB]
        } catch{
            print("error")
        }
        
        return fetchedList
    }
    
    //MARK: - Delete item from db

    func deleteFromCart( cartItem : ShoppingCartDB , indexPath : IndexPath , appDelegate : AppDelegate , delegate : DeletionDelegate) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(cartItem)
        do{
            try managedContext.save()
            delegate.deleteCartItem(indexPath: indexPath)
        }catch {
            print("error")
        }
    }

    //MARK: - Delete All items from db


 func deleteAll(appDelegate : AppDelegate) -> Bool{
    let context = appDelegate.persistentContainer.viewContext
    let delete = NSBatchDeleteRequest(fetchRequest: ShoppingCartDB.fetchRequest())
    
    do{
        try context.execute(delete)
        return true
    }catch{
        return false
    }
 }
    
}
