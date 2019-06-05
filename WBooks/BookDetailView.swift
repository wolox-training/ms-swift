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
    
    @IBOutlet weak var childTopDetailView: UIView!
    @IBOutlet weak var childBottomDetailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor.wLightBlue.cgColor
        childTopDetailView.layer.cornerRadius = 22
    }
}
