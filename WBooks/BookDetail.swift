//
//  BookDetail.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class BookDetail: UIView {
    
    static let xibFileBookDetailName = "BookDetail"

    override func awakeFromNib() {
        // Initialization
        
        layer.cornerRadius = 22
        layer.masksToBounds = true
        
    }
}
