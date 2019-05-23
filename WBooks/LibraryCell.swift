//
//  LibraryCell.swift
//  WBooks
//
//  Created by Matías David Schwalb on 23/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {

    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
