//
//  BookDetailViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class BookDetailViewController: UIViewController {

    private let bookDetailView: BookDetailView = BookDetailView.loadFromNib()!
    private let bookDetail = BookDetailController()
    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDetailView.childDetailView.addSubview(bookDetail.view)
        
    }
}
