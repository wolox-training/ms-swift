//
//  MyCustomCell.swift
//  WBooks
//
//  Created by Matías David Schwalb on 23/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {

    static let xibFileLibraryCellName = "LibraryCell"
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var viewDisplay: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        viewDisplay.layer.cornerRadius = 22
        viewDisplay.layer.masksToBounds = true
        viewDisplay.layer.backgroundColor = UIColor.white.cgColor
 
        layer.cornerRadius = 22
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.wLightBlue.cgColor
        
        topLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        
        topLabel.lineBreakMode = .byWordWrapping
        topLabel.numberOfLines = 0
    
    }
}
