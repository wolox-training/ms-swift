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
 //       let img = UIImage(named: "bc_nav bar")
 //       navigationBar.setBackgroundImage(img, for: .default)
  //      navigationBar.isTranslucent = true
  //      navigationBar.barStyle = .black
   //     navigationBar.alpha = 0.0
        //      setBackgroundImage(img!)
        /*
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
 */
        // Search button
        let searchButton = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.topViewController?.navigationItem.rightBarButtonItem = searchButton
        // Alarm button
        let notificationsButton = UIBarButtonItem(image: UIImage(named: "ic_notifications"), style: .plain, target: self, action: #selector(notificationsButtonTapped))
        self.topViewController?.navigationItem.leftBarButtonItem = notificationsButton
    }
    
    @objc func searchButtonTapped() {
        print("Search button tapped")
    }
    
    @objc func notificationsButtonTapped() {
        print("Notifications button tapped")
    }
}
