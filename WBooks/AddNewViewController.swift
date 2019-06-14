//
//  AddNewViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class AddNewViewController: UIViewController {
    
    private let addNewView: AddNewView = AddNewView.loadFromNib()!
    
    override func loadView() {
        view = addNewView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "ADD_NEW_VIEW_NAVIGATION_TITLE".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
    }
    
}
