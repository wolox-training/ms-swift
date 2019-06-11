//
//  CommentCell.swift
//  WBooks
//
//  Created by Matías David Schwalb on 05/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    static let xibFileCommentCellName = "CommentCell"
    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        userIcon.layer.backgroundColor = UIColor.clear.cgColor
        userIcon.layer.cornerRadius = 20
        userIcon.layer.borderWidth = 2
        userIcon.layer.masksToBounds = true
        userIcon.layer.borderColor = UIColor.white.cgColor
    }

}
