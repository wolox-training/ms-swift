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
        
        let navController = NavigationController(rootViewController: LibraryViewController())
 //       let navigationBar = navigationController?.navigationBar
        let navigationBar = navController.navigationBar
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        logInView.buttonLogIn.addTapGestureRecognizer { _ in
            print("Hi!")
            let navController = NavigationController(rootViewController: LibraryViewController())
            navController.setupNav()
            self.present(navController, animated: true, completion: nil)
        }
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navigationBar = self.navigationController?.navigationBar
        
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.isTranslucent = true
    }*/
}
