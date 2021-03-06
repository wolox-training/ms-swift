//
//  LogInController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class LogInViewController: UIViewController {
    
    @IBOutlet weak var labelCredits: UILabel!
    
    private let logInView: LogInView = LogInView.loadFromNib()!
    
    override func loadView() {
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInView.buttonLogIn.addTapGestureRecognizer { _ in
            let tabController = TabBarController()
            self.present(tabController, animated: true, completion: nil)
        }
    }
}
