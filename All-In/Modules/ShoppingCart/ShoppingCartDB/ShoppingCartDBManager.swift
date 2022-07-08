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

    func saveItemToDB( appDelegate : AppDelegate , title : String ,  quantity : Int32 , price : String , itemId : String , image : String , customerId : String ) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "ShoppingCart", in: managedContext){
            
            let cartItem = NSManagedObject(entity: entity, insertInto: managedContext)
            cartItem.setValue(title, forKey: "title")
            cartItem.setValue(quantity,forKey: "quantity")
            cartItem.setValue(price, forKey: "price")
            cartItem.setValue(itemId, forKey: "itemId")
            cartItem.setValue(image, forKey: "image")
            cartItem.setValue(customerId, forKey: "customerId")
            do{
            try managedContext.save()
            }catch{
                print("error")
            }
        }

    }

    //MARK: - insert item into cart
    func getItemToCart(appDelegate : AppDelegate) -> [ShoppingCart]{
        
        var fetchedList : [ShoppingCart] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCart")
        do{
            fetchedList = try managedContext.fetch(fetchRequest) as! [ShoppingCart]
        } catch{
            print("error")
        }
        
        return fetchedList
    }
    
    //MARK: - Delete item from db

    func deleteFromCart( cartItem : ShoppingCart , indexPath : IndexPath , appDelegate : AppDelegate , delegate : DeletionDelegate) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(cartItem)
        do{
            try managedContext.save()
            delegate.deleteCartItem(indexPath: indexPath)
        }catch {
            print("error")
        }
    }
}
