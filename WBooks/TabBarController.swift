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
        home.tabBarItem = UITabBarItem()
        home.tabBarItem.title = "TAB_LIBRARY_TITLE".localized()
        home.tabBarItem.image = UIImage(named: "ic_library")
        home.tabBarItem.tag = 0
        
        let wishList = WishListViewController()   // Not developed yet
        wishList.tabBarItem = UITabBarItem()
        wishList.tabBarItem.title = "TAB_WISHLIST_TITLE".localized()
        wishList.tabBarItem.image = UIImage(named: "ic_wishlist")
        wishList.tabBarItem.tag = 1
        
        let addNew = AddNewViewController()
        addNew.tabBarItem = UITabBarItem()
        addNew.tabBarItem.title = "TAB_ADDNEW_TITLE".localized()
        addNew.tabBarItem.image = UIImage(named: "ic_add new")
        addNew.tabBarItem.tag = 2
        
        let rentals = RentalsViewController()
        rentals.tabBarItem = UITabBarItem()
        rentals.tabBarItem.title = "TAB_RENTALS_TITLE".localized()
        rentals.tabBarItem.image = UIImage(named: "ic_myrentals")
        rentals.tabBarItem.tag = 3
        
        let settings = SettingsViewController()
        settings.tabBarItem = UITabBarItem()
        settings.tabBarItem.title = "TAB_SETTINGS_TITLE".localized()
        settings.tabBarItem.image = UIImage(named: "ic_settings")
        settings.tabBarItem.tag = 4
        
        viewControllers = [home, wishList, addNew, rentals, settings]
    }
}
