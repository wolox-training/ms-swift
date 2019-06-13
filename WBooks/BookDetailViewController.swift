//
//  BookDetailViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//
import ReactiveSwift
import Result
import ReactiveCocoa
import UIKit

final class BookDetailViewController: UIViewController {
    
    private let bookDetailView: BookDetailView = BookDetailView.loadFromNib()!
    private let bookDetailController = BookDetailController()
    private var bookDetailViewModel: BookDetailViewModel
   // private var commentTableViewController: CommentTableViewController
    private var commentViewController: CommentViewController
    
    private let loadedCommmentsSignalPipe = Signal<Bool, NoError>.pipe()
    var loadedCommentsSignal: Signal<Bool, NoError> {
        return loadedCommmentsSignalPipe.output
    }
    
    deinit {
        loadedCommmentsSignalPipe.input.sendCompleted()
    }
    
    private var commentList: [Comment] = []
    
    init(withBookDetailViewModel: BookDetailViewModel) {
        self.bookDetailViewModel = withBookDetailViewModel
       // super.init(nibName: "BookDetailViewController", bundle: Bundle.main)
    //    self.commentTableViewController = CommentTableViewController(usingViewModel: bookDetailViewModel)
        self.commentViewController = CommentViewController(usingViewModel: bookDetailViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.bookDetailViewModel = BookDetailViewModel(book: Book(status: "-1", id: -1, author: "-1", title: "-1", image: "-1", year: "-1", genre: "-1"))
      //  self.commentTableViewController = CommentTableViewController(usingViewModel: bookDetailViewModel)
        self.commentViewController = CommentViewController(usingViewModel: bookDetailViewModel)
        super.init(coder: aDecoder)
    }

    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookDetailViewModel.changeLabelSignal.observeValues { data in
            DispatchQueue.main.async {
                self.bookDetailController.bookDetail.statusLabel.text = data.capitalized
                if data == "available" {
                    self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wOliveGreen
                } else if data == "rented" {
                    self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wRentedYellow
                }
            }
        }
        setupNav()
   
      //  let nib = UINib(nibName: CommentCell.xibFileCommentCellName, bundle: nil)
      //  bookDetailView.commentTable.register(nib, forCellReuseIdentifier: CommentCell.xibFileCommentCellName)
     //   bookDetailView.commentTable.delegate = self
       // bookDetailView.commentTable.dataSource = self
        
        bookDetailController.bookDetail.rentButton.addTapGestureRecognizer { _ in
            print("Rent Button tapped")
         //   self.bookDetailViewModel.rent()
            
            self.bookDetailViewModel.finishedRentingSignal.observeResult { result in
                if result.value == 1 {
                    self.rentRequestSuccessful()
                } else if result.value == 2 {
                    self.bookIsUnavailable()
                }
                
                if result.error != nil {
                    self.rentRequestFailed()
                }
            }
            
            self.bookDetailViewModel.rent()
        }
        
        bookDetailController.bookDetail.addToWishlistButton.addTapGestureRecognizer { _ in
            print("Add to wishlist button tapped")
        }
        
        setupBindings()

    }

    func setupBindings() {
        bookDetailViewModel.comments.producer.startWithValues { [unowned self ] _ in
            //self.bookDetailView.commentTable.reloadData()
            self.commentViewController.commentView.commentTable.reloadData()
        }
    }
    
    func bookIsUnavailable() {
        // Alert popup (error), book is already rented
        let alert = UIAlertController(title: "DETAIL_ALERT_ERROR_TITLE".localized(), message: "DETAIL_ALERT_ERROR_RENTED".localized(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "DETAIL_ALERT_OK".localized(), style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func rentRequestSuccessful() {
        // Alert popup, book successfully rented
        let alert = UIAlertController(title: "DETAIL_ALERT_BOOK_RENTED_TITLE".localized(), message: "DETAIL_ALERT_BOOK_RENTED_MESSAGE".localized(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "DETAIL_ALERT_OK".localized(), style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func rentRequestFailed() {
        // Alert popup (error), couldn't fetch request from server
        let alert = UIAlertController(title: "DETAIL_ALERT_ERROR_TITLE".localized(), message: "DETAIL_ALERT_ERROR_PUSH".localized(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "DETAIL_ALERT_OK".localized(), style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func setupNav() {
        loadBookDetails()
        setNavigationBar()
        bookDetailView.childBottomDetailView.addSubview(commentViewController.view)
    }
    
    func loadBookDetails() {
        bookDetailView.childTopDetailView.addSubview(bookDetailController.view)
        
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
        if let url = bookDetailViewModel.book.imageUrl {
            bookDetailController.bookDetail.bookCover?.load(url: url)
        }
    }
    
    func setNavigationBar() {
        navigationItem.title = "DETAIL_VIEW_NAVIGATION_TITLE".localized()
    }
}
/*
extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookDetailViewModel.comments.value.count
    }
    
    // Hard coded to fit all info. Should be replaced to dynamic height in function of components
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    // Cell generator
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.xibFileCommentCellName) as? CommentCell else {
            return UITableViewCell()
        }
        
        cell.usernameLabel?.text = bookDetailViewModel.comments.value[indexPath.row].user.username
        cell.commentLabel?.text = bookDetailViewModel.comments.value[indexPath.row].content
        
        cell.userIcon?.image = UIImage()   // Add grey frame to make loading prettier
        
        if let url = URL(string: bookDetailViewModel.comments.value[indexPath.row].user.image) {
            cell.userIcon?.load(url: url)
        }
        
        return cell
    }
}
*/
