//
//  BookDetail.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class BookDetail: UIView, NibLoadable {
    
    override func awakeFromNib() {
        // Initialization
        super.awakeFromNib()
        layer.cornerRadius = 22
        layer.masksToBounds = true
        
    }
}
