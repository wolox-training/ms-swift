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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
}

private extension LogInView {
    
    func setupView() {
        
    }
}

