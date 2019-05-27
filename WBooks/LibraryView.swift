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
    @IBOutlet weak var tblBooks: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
}

private extension LibraryView {
    
    func setupView() {
        let tableBackgroundColor = UIColor(displayP3Red: 231.0 / 255.0, green: 245.0 / 255.0, blue: 249.0 / 255.0, alpha: 1)
        self.layer.backgroundColor = tableBackgroundColor.cgColor
        tblBooks.layer.backgroundColor = UIColor.clear.cgColor
        
  //      barImage.isHidden = true // Delete this after debugging navigation controller
    }
    
}
