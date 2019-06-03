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
        self.book = Book(status: "nil", id: -1, author: "nil", title: "nil", image: "nil", year: "nil", genre: "nil")
        super.init(coder: aDecoder)
    }

    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        
        bookDetailController.bookDetail.rentButton.addTapGestureRecognizer { _ in
            print("Rent Button tapped")
        }
        
        bookDetailController.bookDetail.addToWishlistButton.addTapGestureRecognizer { _ in
            print("Add to wishlist button tapped")
        }
    }
    
    func setupNav() {
        loadBookDetails()
        setNavigationBar()
    }
    
    func loadBookDetails() {
        bookDetailView.childDetailView.addSubview(bookDetailController.view)
        let bookDetailViewModel = BookDetailViewModel(book: book)
        if bookDetailViewModel.book.status == "available" {
            bookDetailController.bookDetail.statusLabel.textColor = UIColor.wOliveGreen
        } else if bookDetailViewModel.book.status == "rented"{
            bookDetailController.bookDetail.statusLabel.textColor = UIColor.wRentedYellow
        } else {
            bookDetailController.bookDetail.statusLabel.textColor = UIColor.red
        }
        bookDetailController.bookDetail.statusLabel.text = bookDetailViewModel.book.status.capitalized
        bookDetailController.bookDetail.titleLabel.text = bookDetailViewModel.book.title.capitalized
        bookDetailController.bookDetail.authorLabel.text = bookDetailViewModel.book.author.capitalized
        bookDetailController.bookDetail.yearLabel.text = bookDetailViewModel.book.year
        bookDetailController.bookDetail.genreLabel.text = bookDetailViewModel.book.genre.capitalized
        bookDetailController.bookDetail.bookCover.image = UIImage()
        if let url = book.imageUrl {
            bookDetailController.bookDetail.bookCover?.load(url: url)
        }
    }
    
    func setNavigationBar() {
        navigationItem.title = "DETAIL_VIEW_NAVIGATION_TITLE".localized()
    }
}
