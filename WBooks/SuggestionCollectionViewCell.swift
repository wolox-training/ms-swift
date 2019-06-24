//
//  SuggestionCollectionViewCell.swift
//  WBooks
//
//  Created by Matías David Schwalb on 18/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {

    static let xibFileSuggestionCollectionViewCell = "SuggestionCollectionViewCell"
    
    @IBOutlet weak var bookCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
