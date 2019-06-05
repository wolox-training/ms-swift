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
    private var bookDetailViewModel = BookDetailViewModel(book: Book(status: "nil", id: -1, author: "nil", title: "nil", image: "nil", year: "nil", genre: "nil"))
    
    let dispatchGroup = DispatchGroup()
    
    init(book: Book) {
        self.book = book
        self.bookDetailViewModel.book = book
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
        return book.status == "available"
    }
    
    func requestRent() -> Bool {
        var exitValue: Bool = false
        dispatchGroup.enter()
        
        DispatchQueue.global().sync {
            
            let today: String = Date.getCurrentDateYYYY_MM_DD()
            let tomorrow: String = Date.addDaysToCurrentDateYYYY_MM_DD(daysToAdd: 1)
            let userID = Int(AuthUser().sessionToken!)
            let bookID = self.bookDetailViewModel.book.id
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
            if self.bookDetailViewModel.book.status == "available" {
                self.bookDetailViewModel.book.status = "rented"
                self.saveChangesOnBookDatabase()
                self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wRentedYellow
            } else if self.bookDetailViewModel.book.status == "rented" {
                self.bookDetailViewModel.book.status = "available"
                self.saveChangesOnBookDatabase()
                self.bookDetailController.bookDetail.statusLabel.textColor = UIColor.wOliveGreen
            }
            self.bookDetailController.bookDetail.statusLabel.text = self.bookDetailViewModel.book.status.capitalized
        }
    }
    
    func saveChangesOnBookDatabase() {
        var index = 0
        while book.id != BookDB.bookArrayDB[index].id {
            index += 1
        }
        
        BookDB.bookArrayDB[index].status = bookDetailViewModel.book.status
    }
    
    func setupNav() {
        loadBookDetails()
        setNavigationBar()
    }
    
    func loadBookDetails() {
        bookDetailView.childDetailView.addSubview(bookDetailController.view)
    //    let bookDetailViewModel = BookDetailViewModel(book: book)
        
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
