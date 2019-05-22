//
//  LogInController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class LogInViewController: UIViewController {
    
    private let logInView: LogInView = LogInView.loadFromNib()!
    
    override func loadView() {
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        view.backgroundColor = UIColor.white
        
        let frame = CGRect(x: 0, y: view.frame.size.height / 2 - 11, width: view.frame.size.width, height: 22)
        let label = UILabel(frame: frame)
        label.text = "Welcome! This is a new blank project"
        label.textAlignment = .center
        label.sizeToFit()
        view.addSubview(label)
         */
        // assignBackground(named: "bc_inicio")
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bc_inicio"))
    }
    
    
    func assignBackground(named background: String) {
        let backgroundImage = UIImage(named: background)
        
        // BUG: Background Image not displaying correctly in iPhone Xr
        var backgroundView: UIImageView!
        backgroundView = UIImageView(frame: view.frame)
        backgroundView.contentMode = UIViewContentMode.scaleAspectFill
        backgroundView.clipsToBounds = false
        backgroundView.image = backgroundImage
        backgroundView.center = view.center
        view.addSubview(backgroundView)
        self.view.sendSubview(toBack: backgroundView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
