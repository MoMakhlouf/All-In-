//
//  ViewController.swift
//  All-In
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK:- homeTabBar
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), tag: 1)
        let homeController = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        homeNavigationController.tabBarItem = homeTabBarItem
        
        //MARK:- categoriesTabBar
        let categoriesTabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "square.grid.2x2"), tag: 2)
        let categoriesController = CategoriesViewController()
        let caregoriesNavigationController = UINavigationController(rootViewController: categoriesController)
        caregoriesNavigationController.tabBarItem = categoriesTabBarItem
        
        
      // MARK:- ordersTabBar
        let ordersTabBarItem = UITabBarItem(title: "My Account", image: UIImage(systemName: "person.circle"), tag: 3)
        let ordersController = OrdersViewController()
        let ordersNavigationController = UINavigationController(rootViewController: ordersController)
        ordersNavigationController.tabBarItem = ordersTabBarItem

        
        self.viewControllers = [homeNavigationController , caregoriesNavigationController, ordersNavigationController]
       
        tabBar.tintColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1) //.white
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4431372549, green: 0.1607843137, blue: 0.4235294118, alpha: 1)
        navigationController?.isNavigationBarHidden = true
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
