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
    
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "heart.fill"), tag: 1)
        let homeController = ShoppingCartViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        homeNavigationController.tabBarItem = homeTabBarItem
        
        
        
//        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "heart.fill"), tag: 1)
//        let homeController = PaymentViewController()
//        let homeNavigationController = UINavigationController(rootViewController: homeController)
//        homeNavigationController.tabBarItem = homeTabBarItem


        
        
        
        
        self.viewControllers = [homeNavigationController]
        
        
        
        
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
