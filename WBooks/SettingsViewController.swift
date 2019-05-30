//
//  SettingsViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let settingsView: SettingsView = SettingsView.loadFromNib()!
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
