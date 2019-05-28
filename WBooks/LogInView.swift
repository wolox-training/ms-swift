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
        // 19 Works for iPhone Xr (896 pts high), factor it by the height of the actual screen size relation for smaller devices
        let buttonFontSize: CGFloat = 19 * (UIScreen.main.bounds.height / 896)
        // 45 Works for iPhone Xr (896 pts high), factor it by the height of the actual screen size relation for smaller devices
        buttonLogIn.layer.cornerRadius = 45 * (UIScreen.main.bounds.height / 896)
        buttonLogIn.clipsToBounds = true
        buttonLogIn.layer.borderColor = UIColor.white.cgColor
        buttonLogIn.layer.borderWidth = 4
        buttonLogIn.titleLabel?.font = UIFont.boldSystemFont(ofSize: buttonFontSize)
        buttonLogIn.setTitle("LOGIN_BUTTON_TITLE".localized(), for: .normal)
    }
}
