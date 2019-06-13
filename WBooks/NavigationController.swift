//
//  NavigationController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 27/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

final class NavigationController: UINavigationController {
    	func setupNav() {
        // Search button
        let searchButton = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .plain, target: self, action: #selector(searchButtonTapped))
        topViewController?.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        topViewController?.navigationItem.rightBarButtonItem = searchButton
        
        // Notifications button
        let notificationsButton = UIBarButtonItem(image: UIImage(named: "ic_notifications"), style: .plain, target: self, action: #selector(notificationsButtonTapped))
        topViewController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        topViewController?.navigationItem.leftBarButtonItem = notificationsButton

    }
    @objc func searchButtonTapped() {
        print("Search button tapped")
    }
    
    @objc func notificationsButtonTapped() {
        print("Notifications button tapped")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // The following only works on this specific method
        let navigationBar = self.navigationBar
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.white
        
//        navigationBar.topItem?.title = "LIBRARY_VIEW_NAVIGATION_TITLE".localized()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}
