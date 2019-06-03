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
    @IBOutlet weak var statusLabel: UILabel!
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
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        statusLabel.font = UIFont.boldSystemFont(ofSize: 12)
        statusLabel.textColor = UIColor.wOliveGreen
        
        addToWishlistButton.clipsToBounds = true
        addToWishlistButton.layer.borderColor = UIColor.wBlue.cgColor
        addToWishlistButton.layer.borderWidth = 1
        addToWishlistButton.layer.cornerRadius = 25 * (UIScreen.main.bounds.height / 896)
        addToWishlistButton.setTitle("DETAIL_WISHLIST_BUTTON_TITLE".localized(), for: .normal)
        addToWishlistButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 * (UIScreen.main.bounds.height / 896))
        addToWishlistButton.setTitleColor(UIColor.wBlue, for: .normal)
        addToWishlistButton.heightAnchor.constraint(equalToConstant: 53.0).isActive = true
        
        rentButton.clipsToBounds = true
        rentButton.layer.borderColor = UIColor.wBlue.cgColor
        rentButton.layer.borderWidth = 4
        rentButton.layer.cornerRadius = 25 * (UIScreen.main.bounds.height / 896)
        rentButton.backgroundColor = UIColor.wBlue
        rentButton.setTitle("DETAIL_RENT_BUTTON_TITLE".localized(), for: .normal)
        rentButton.setTitle("PRESSED AAAA", for: .highlighted)
        rentButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 * (UIScreen.main.bounds.height / 896))
        rentButton.setTitleColor(UIColor.white, for: .normal)
        rentButton.heightAnchor.constraint(equalToConstant: 53.0).isActive = true
    }
}
