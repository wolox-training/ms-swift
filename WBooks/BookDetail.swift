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
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        // Initialization
        super.awakeFromNib()
        layer.cornerRadius = 22
        layer.masksToBounds = true
        whiteView.layer.cornerRadius = 22
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
     //   titleLabel.minimumScaleFactor = 10/UIFont.labelFontSize
    //    titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        availabilityLabel.font = UIFont.boldSystemFont(ofSize: 12)
        availabilityLabel.textColor = UIColor.green
        
       // clipsToBounds = true
       // frame = CGRect(origin: CGPoint(x: 80, y: 100), size: self.frame.size)
    }
}
