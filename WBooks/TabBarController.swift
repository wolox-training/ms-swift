//
//  TabBarController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 27/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = NavigationController(rootViewController: LibraryViewController())
        home.setupNav()
   //    let home = LibraryViewController()
        home.tabBarItem = UITabBarItem()
        home.tabBarItem.title = "Library"
        home.tabBarItem.image = UIImage(named: "ic_library")
        home.tabBarItem.tag = 0
        print(home)
        
        let wishList = WishListViewController()   // Not developed yet
//        let wishList = LogInViewController()    // Using LogInViewController for debugging until WishList is developed
        wishList.tabBarItem = UITabBarItem()
        wishList.tabBarItem.title = "Wishlist"
        wishList.tabBarItem.image = UIImage(named: "ic_wishlist")
        wishList.tabBarItem.tag = 1
        
        viewControllers = [home, wishList]
    }
}
