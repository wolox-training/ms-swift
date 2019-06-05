//
//  CommentsController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 05/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class CommentsController: UIViewController {
    
    let comments: Comments = Comments.loadFromNib()!
    
    override func loadView() {
        view = comments
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
