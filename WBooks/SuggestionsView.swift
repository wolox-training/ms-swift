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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

private extension SuggestionsView {
    func setupView() {
        
    }
}
