//
//  RentalsView.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class RentalsView: UIView, NibLoadable {
    
    @IBOutlet weak var tableRentals: UITableView!
    @IBOutlet weak var carrousselChildView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

private extension RentalsView {
    func setupView() {
        layer.backgroundColor = UIColor.wLightBlue.cgColor
        tableRentals.layer.backgroundColor = UIColor.clear.cgColor
    }
}
