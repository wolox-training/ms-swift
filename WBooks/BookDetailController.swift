//
//  BookDetail.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

class BookDetailController: UIViewController {
    
    let bookDetail: BookDetail = BookDetail.loadFromNib()!
    
    override func loadView() {
        view = bookDetail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
