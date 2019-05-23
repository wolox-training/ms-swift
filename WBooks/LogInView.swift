//
//  LogIn.swift
//  WBooks
//
//  Created by Matías David Schwalb on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class LogInView: UIView, NibLoadable {
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var labelCredits: UILabel!
    @IBOutlet weak var buttonLogIn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
}

private extension LogInView {
    
    func setupView() {
        setButtonView()
    }

    func setButtonView() {
        buttonLogIn.layer.cornerRadius = 50
        buttonLogIn.clipsToBounds = true
        buttonLogIn.layer.borderColor = UIColor.white.cgColor
        buttonLogIn.layer.borderWidth = 4
        buttonLogIn.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }
    @objc func logInButtonPressed() {
        print("Button pressed!")
    }
}
