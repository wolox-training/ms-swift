//
//  CommentView.swift
//  WBooks
//
//  Created by Matías David Schwalb on 13/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

class CommentView: UIView, NibLoadable {
    
    @IBOutlet weak var commentTable: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

private extension CommentView {
    func setupView() {
    }
}
