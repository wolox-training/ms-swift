//
//  ViewController.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

final class LibraryViewController: UIViewController {
  
    let dispatchGroup = DispatchGroup()
    
    private let libraryView: LibraryView = LibraryView.loadFromNib()!
    
    static let spacingBetweenCells: CGFloat = 10
    
    // MVVM
    private let libraryViewModel: LibraryViewModel = LibraryViewModel()
    
    override func loadView() {
        view = libraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: LibraryCell.xibFileLibraryCellName, bundle: nil)
        libraryView.tableBooks.register(nib, forCellReuseIdentifier: LibraryCell.xibFileLibraryCellName)
        libraryView.tableBooks.delegate = self  
        libraryView.tableBooks.dataSource = self

        setupBindings()
    }
    
    func makeAllBooksAvailable() {
        for index in 0..<BookDB.bookArrayDB.count {
            BookDB.bookArrayDB[index].status = "available"
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        loadBooksToAppDatabase()
        return libraryViewModel.books.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Hard coded to fit all info. Should be replaced to dynamic height in function of components
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    // Spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LibraryViewController.spacingBetweenCells
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    // Cell generator
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.xibFileLibraryCellName) as? LibraryCell else {
            return UITableViewCell()
        }
        loadBooksToAppDatabase()

        let book: Book = BookDB.bookArrayDB[indexPath.section]
        
        cell.imageBook?.image = UIImage()   // Add grey frame to make loading prettier
        
        if let url = book.imageUrl {
            cell.imageBook?.load(url: url)
        }
        
        cell.topLabel?.text = book.title
        cell.bottomLabel?.text = book.author
        
        cell.addTapGestureRecognizer { _ in
          //  CommentDB.commentArray = [] // Reset comment buffer
            let bookDetailViewController = BookDetailViewController(withBookDetailViewModel: BookDetailViewModel(book: book))
            self.navigationController?.pushViewController(bookDetailViewController, animated: true)
            self.makeAllBooksAvailable() // Added for debugging. Should be deleted when book API is fixed
        }
        
        return cell
    }
}

private extension LibraryViewController {
    
    func setupBindings() {
        libraryViewModel.books.producer.startWithValues { [unowned self] _ in
            self.libraryView.tableBooks.reloadData()
        }
    }
    
    func loadBooksToAppDatabase() {
        if BookDB.loadedFromAPI == false {
            BookDB.bookArrayDB = libraryViewModel.books.value
            if BookDB.bookArrayDB.count != 0 {
                BookDB.loadedFromAPI = true
            }
        }
    }
}
