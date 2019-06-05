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
    private let commentsController = CommentsController()
    
    let dispatchGroup = DispatchGroup()
    
    init(bookID: Int) {
        self.bookID = bookID-1
        self.bookDetailViewModel.bookID = bookID
        super.init(nibName: "BookDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.bookID = -1
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
            self.rent()
        }
        
        bookDetailController.bookDetail.addToWishlistButton.addTapGestureRecognizer { _ in
            print("Add to wishlist button tapped")
        }
    }
    
    func rent() {
        var rentStatus: Bool = true
        if checkBookStatus() {
            
            dispatchGroup.notify(queue: .main) {
                rentStatus = self.requestRent()
            }
            
            if rentStatus {
                rentRequestSuccessful()
            } else {
                rentRequestFailed()
            }
        } else {
            bookIsUnavailable()
        }
        
    }
    
    func checkBookStatus() -> Bool {
        return BookDB.bookArrayDB[bookID].status == "available"
    }
    
    func requestRent() -> Bool {
        var exitValue: Bool = false
        dispatchGroup.enter()
        
        DispatchQueue.global().sync {
            
            let today: String = Date.getCurrentDateYYYY_MM_DD()
            let tomorrow: String = Date.addDaysToCurrentDateYYYY_MM_DD(daysToAdd: 1)
            let userID = Int(AuthUser().sessionToken!)
            let bookID = self.bookID
            let parameters = ["userID": userID!,
                              "bookID": bookID,
                              "from": today,
                              "to": tomorrow] as [String: Any]
     
            guard let url = URL(string: "https://swift-training-backend.herokuapp.com/users/user_id/rents") else {
                exitValue = false
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                exitValue = false
                return
            }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print (response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        exitValue = true
                        self.changeStatusOnBookStructure()
                    } catch {
                        print(error)
                        exitValue = false
                    }
                }
            }.resume()

        }
            dispatchGroup.leave()
            return exitValue
    }
    
    func bookIsUnavailable() {
        // Alert popup (error), book is already rented
        let alert = UIAlertController(title: "DETAIL_ALERT_ERROR_TITLE".localized(), message: "DETAIL_ALERT_ERROR_RENTED".localized(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "DETAIL_ALERT_OK".localized(), style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func rentRequestSuccessful() {
        // Alert popup, book successfully rented
        let alert = UIAlertController(title: "DETAIL_ALERT_BOOK_RENTED_TITLE".localized(), message: "DETAIL_ALERT_BOOK_RENTED_MESSAGE".localized(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "DETAIL_ALERT_OK".localized(), style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func rentRequestFailed() {
        // Alert popup (error), couldn't fetch request from server
        let alert = UIAlertController(title: "DETAIL_ALERT_ERROR_TITLE".localized(), message: "DETAIL_ALERT_ERROR_PUSH".localized(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "DETAIL_ALERT_OK".localized(), style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeStatusOnBookStructure() {
        // Works only in display view. Must make the book in-app book database global to keep changes when changing views
        DispatchQueue.main.async {
            if BookDB.bookArrayDB[self.bookID].status == "available" {
                BookDB.bookArrayDB[self.bookID].status = "rented"
        //        self.saveChangesOnBookDatabase()
                self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wRentedYellow
            } else if BookDB.bookArrayDB[self.bookID].status == "rented" {
                BookDB.bookArrayDB[self.bookID].status = "available"
        //         self.saveChangesOnBookDatabase()
                self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wOliveGreen
            }
            self.bookDetailController.bookDetail.statusLabel.text = BookDB.bookArrayDB[self.bookID].status.capitalized
        }
    }
    /*
    func saveChangesOnBookDatabase() {
        BookDB.bookArrayDB[self.bookID].status = bookDetailViewModel.book.status
    }
    */
    func setupNav() {
        loadBookDetails()
        setNavigationBar()
        loadComments()
    }
    
    func loadComments() {
        bookDetailView.childBottomDetailView.addSubview(commentsController.view)
    }
    
    func loadBookDetails() {
        bookDetailView.childTopDetailView.addSubview(bookDetailController.view)
    //    let bookDetailViewModel = BookDetailViewModel(book: book)
        
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
