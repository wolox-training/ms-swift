//
//  BookDetailView.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class BookDetailView: UIView, NibLoadable {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor(displayP3Red: 231.0 / 255.0, green: 245.0 / 255.0, blue: 249.0 / 255.0, alpha: 1).cgColor
    }
}
