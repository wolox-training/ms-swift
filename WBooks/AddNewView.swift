//
//  AddNewView.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class AddNewView: UIView, NibLoadable {
    @IBOutlet weak var childView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

private extension AddNewView {
    func setupView() {
        layer.backgroundColor = UIColor.wLightBlue.cgColor
        childView.layer.cornerRadius = 22
    }
}
