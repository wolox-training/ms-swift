//
//  LibraryView.swift
//  WBooks
//
//  Created by Matías David Schwalb on 22/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class LibraryView: UIView, NibLoadable {
    
    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var tableBooks: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
}

private extension LibraryView {
    
    func setupView() {
        layer.backgroundColor = UIColor.wLightBlue.cgColor
        tableBooks.layer.backgroundColor = UIColor.clear.cgColor
    }
    
}
