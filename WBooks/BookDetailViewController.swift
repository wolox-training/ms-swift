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
            self.rent()
        }
        
        bookDetailController.bookDetail.addToWishlistButton.addTapGestureRecognizer { _ in
            print("Add to wishlist button tapped")
        }
    }
    
    func rent() {
        if checkBookStatus() {
            if requestRent() {
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
        // Hard coded, the API request function goes here
        var exitValue: Bool = true
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        DispatchQueue.global().async {
            let parameters = ["userID": 2,
                              "bookID": 5,
                              "from": "2019-06-04",
                              "to": "2019-06-05"] as [String: Any]
     
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
                    } catch {
                        print(error)
                        exitValue = false
                    }
                }
            }.resume()
        dispatchGroup.leave()
        }
        dispatchGroup.wait()
        return exitValue
    }
    
    func bookIsUnavailable() {
        // Alert popup (error), book is already rented
        let alert = UIAlertController(title: "Error", message: "Book already rented", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func rentRequestSuccessful() {
        // Alert popup, book successfully rented
        let alert = UIAlertController(title: "Book rented", message: "Book rented successfully", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func rentRequestFailed() {
        // Alert popup (error), couldn't fetch request from server
        let alert = UIAlertController(title: "Error", message: "Couldn't push request to server", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
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
