//
//  MyCustomCell.swift
//  WBooks
//
//  Created by Matías David Schwalb on 23/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {

    static let xibFileCellName = "LibraryCell"
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var viewDisplay: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellBackgroundColor = UIColor(displayP3Red: 231.0 / 255.0, green: 245.0 / 255.0, blue: 249.0 / 255.0, alpha: 1)
       
        viewDisplay.layer.cornerRadius = 22
        viewDisplay.layer.masksToBounds = true
        viewDisplay.layer.backgroundColor = UIColor.white.cgColor
 
        layer.cornerRadius = 22
        layer.masksToBounds = true
        layer.backgroundColor = cellBackgroundColor.cgColor
        
        topLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        
        topLabel.lineBreakMode = .byWordWrapping
        topLabel.numberOfLines = 0
    
    }
}
