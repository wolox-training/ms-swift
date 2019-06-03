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
    @IBOutlet weak var addToWishlistButton: UIButton!
    @IBOutlet weak var rentButton: UIButton!
    
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
        
        addToWishlistButton.clipsToBounds = true
        addToWishlistButton.layer.borderColor = UIColor.red.cgColor
        addToWishlistButton.layer.borderWidth = 4
        addToWishlistButton.layer.cornerRadius = 30 * (UIScreen.main.bounds.height / 896)
        addToWishlistButton.setTitle("DETAIL_WISHLIST_BUTTON_TITLE".localized(), for: .normal)
        addToWishlistButton.heightAnchor.constraint(equalToConstant: 53.0).isActive = true
        
        rentButton.clipsToBounds = true
        rentButton.layer.borderColor = UIColor.red.cgColor
        rentButton.layer.borderWidth = 4
        rentButton.layer.cornerRadius = 30 * (UIScreen.main.bounds.height / 896)
        rentButton.setTitle("DETAIL_RENT_BUTTON_TITLE".localized(), for: .normal)
        rentButton.heightAnchor.constraint(equalToConstant: 53.0).isActive = true
        
       // clipsToBounds = true
       // frame = CGRect(origin: CGPoint(x: 80, y: 100), size: self.frame.size)
    }
}
