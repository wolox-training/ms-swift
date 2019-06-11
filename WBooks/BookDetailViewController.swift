//
//  BookDetailViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import UIKit

final class BookDetailViewController: UIViewController {

    private let bookID: Int
    private let bookDetailView: BookDetailView = BookDetailView.loadFromNib()!
    private let bookDetailController = BookDetailController()
    private var bookDetailViewModel = BookDetailViewModel(bookID: -1)
    
    private var commentList: [Comment]
    
    let dispatchGroup = DispatchGroup()
    
    init(bookID: Int) {
        self.bookID = bookID-1
        self.bookDetailViewModel.bookID = bookID
        commentList = CommentDB.getCommentsUsingBookID(bookID: bookID)
        super.init(nibName: "BookDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.bookID = -1
        self.commentList = []
        super.init(coder: aDecoder)
    }

    override func loadView() {
        view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookDetailViewModel.changeLabelSignal.observeValues { data in
            print("Got data: \(data)")
        }
        setupNav()
        
        let nib = UINib(nibName: CommentCell.xibFileCommentCellName, bundle: nil)
        bookDetailView.commentTable.register(nib, forCellReuseIdentifier: CommentCell.xibFileCommentCellName)
        bookDetailView.commentTable.delegate = self
        bookDetailView.commentTable.dataSource = self
        
        dispatchGroup.notify(queue: .main) {
            self.bookDetailView.commentTable.reloadData()
        }
        
        bookDetailController.bookDetail.rentButton.addTapGestureRecognizer { _ in
            print("Rent Button tapped")
            let rentResult = self.bookDetailViewModel.rent()
            
            switch rentResult {
            case 2: // hardcoded for debugging - change 0 to 2
                self.rentRequestSuccessful()
            case 0: // hardcoded for debugging - change 2 to 0
                self.bookIsUnavailable()
            default:
                self.rentRequestFailed()    // If rentResult == 1 or otherwise (!= 0, != 2), it failed
            }
        }
        
        bookDetailController.bookDetail.addToWishlistButton.addTapGestureRecognizer { _ in
            print("Add to wishlist button tapped")
            self.bookDetailViewModel.sendSignal()
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
            dispatchGroup.notify(queue: .main) {
                self.loadComments()
            }
    }
    
    func loadComments() {
        dispatchGroup.enter()
        
        DispatchQueue.global().sync {
            let url = URL(string: "https://swift-training-backend.herokuapp.com/books/\(bookID+1)/comments")!
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let response = response {
                    print(response)
                    
                    if let data = data, let _ = String(data: data, encoding: .utf8) {
                        do {
                            try JSONSerialization.jsonObject(with: data, options: [])
                            let decoder = JSONDecoder()
                            do {
                                let jsonCommentList: [CommentFromJSON]
                                jsonCommentList = try decoder.decode([CommentFromJSON].self, from: data)
                                for index in 0..<jsonCommentList.count {
                                    jsonCommentList[index].loadFromJSONToDataBase()
                                }
                                DispatchQueue.main.async {
                                    self.bookDetailView.commentTable.reloadData()
                                }
                            } catch {
                                print(error)
                            }
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print(error ?? "Unknown error")
                }
            }
            task.resume()
        }
        dispatchGroup.leave()
    }
    
    func loadBookDetails() {
        bookDetailView.childDetailView.addSubview(bookDetailController.view)
        
        if BookDB.bookArrayDB[self.bookID].status == "available" {
            bookDetailController.bookDetail.statusLabel.textColor = UIColor.wOliveGreen
        } else if BookDB.bookArrayDB[self.bookID].status == "rented"{
            bookDetailController.bookDetail.statusLabel.textColor = UIColor.wRentedYellow
        } else {
            bookDetailController.bookDetail.statusLabel.textColor = UIColor.red
        }
        bookDetailController.bookDetail.statusLabel.text = BookDB.bookArrayDB[self.bookID].status.capitalized
        bookDetailController.bookDetail.titleLabel.text = BookDB.bookArrayDB[self.bookID].title.capitalized
        bookDetailController.bookDetail.authorLabel.text = BookDB.bookArrayDB[self.bookID].author.capitalized
        bookDetailController.bookDetail.yearLabel.text = BookDB.bookArrayDB[self.bookID].year
        bookDetailController.bookDetail.genreLabel.text = BookDB.bookArrayDB[self.bookID].genre.capitalized
        bookDetailController.bookDetail.bookCover.image = UIImage()
        if let url = BookDB.bookArrayDB[self.bookID].imageUrl {
            bookDetailController.bookDetail.bookCover?.load(url: url)
        }
    }
    
    func setNavigationBar() {
        navigationItem.title = "DETAIL_VIEW_NAVIGATION_TITLE".localized()
    }
}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentDB.commentArray.count
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
        
        cell.usernameLabel?.text = CommentDB.commentArray[indexPath.row].comment.username
        cell.commentLabel?.text = CommentDB.commentArray[indexPath.row].comment.comment
        
        cell.userIcon?.image = UIImage()   // Add grey frame to make loading prettier
        
        if let url = URL(string: CommentDB.commentArray[indexPath.row].comment.image) {
            cell.userIcon?.load(url: url)
        }
        
        return cell
    }
}
