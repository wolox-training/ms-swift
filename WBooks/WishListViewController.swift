//
//  WishListViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 27/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class WishListViewController: UIViewController {
    
    private let whishListView: WishListView = WishListView.loadFromNib()!
    
    override func loadView() {
        view = wishListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    }
}
