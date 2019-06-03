//
//  BookDetailViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class BookDetailViewController: UIViewController {

    private let book: Book
    private let bookDetailView: BookDetailView = BookDetailView.loadFromNib()!
    private let bookDetailController = BookDetailController()

    init(book: Book) {
        self.book = book
        super.init(nibName: "BookDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.book = Book(id: -1, author: "nil", title: "nil", image: "nil", year: "nil", genre: "nil")
        super.init(coder: aDecoder)
    }

    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDetailView.childDetailView.addSubview(bookDetailController.view)
        let bookDetailViewModel = BookDetailViewModel(book: book)
        bookDetailController.bookDetail.titleLabel.text = bookDetailViewModel.book.title
        bookDetailController.bookDetail.authorLabel.text = bookDetailViewModel.book.author
        bookDetailController.bookDetail.yearLabel.text = bookDetailViewModel.book.year
        bookDetailController.bookDetail.genreLabel.text = bookDetailViewModel.book.genre
        bookDetailController.bookDetail.bookCover.image = UIImage()
        if let url = book.imageUrl {
            bookDetailController.bookDetail.bookCover?.load(url: url)
        }
    }
}
