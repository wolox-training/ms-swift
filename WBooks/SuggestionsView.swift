//
//  SuggestionsView.swift
//  WBooks
//
//  Created by Matías David Schwalb on 18/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class SuggestionsView: UIView, NibLoadable {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var suggestionsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

private extension SuggestionsView {
    func setupView() {
        collectionView.layer.backgroundColor = UIColor.clear.cgColor
        suggestionsLabel.font = UIFont.boldSystemFont(ofSize: 17)
        layer.backgroundColor = UIColor.clear.cgColor
    }
}
