//
//  RentalsViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class RentalsViewController: UIViewController {
    
    private let rentalsView: RentalsView = RentalsView.loadFromNib()!
    
    override func loadView() {
        view = rentalsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
