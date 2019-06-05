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
    
    @IBOutlet weak var childDetailView: UIView!
    @IBOutlet weak var commentTable: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = UIColor.wLightBlue.cgColor
        childDetailView.layer.cornerRadius = 22
    }
}
