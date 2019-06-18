//
//  RentalsViewController.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

final class RentalsViewController: UIViewController {
    
    private let rentalsView: RentalsView = RentalsView.loadFromNib()!
    private let rentalsViewModel: RentalsViewModel = RentalsViewModel()
    
    override func loadView() {
        view = rentalsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "MY RENTALS"
        rentalsViewModel.updateRepository()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: LibraryCell.xibFileLibraryCellName, bundle: nil)
        rentalsView.tableRentals.register(nib, forCellReuseIdentifier: LibraryCell.xibFileLibraryCellName)
        rentalsView.tableRentals.delegate = self
        rentalsView.tableRentals.dataSource = self
        
        setupBindings()
    }
}

extension RentalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rentalsViewModel.rentedBooks.value.count
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
        return 10
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
        
        let book: Book = rentalsViewModel.rentedBooks.value[indexPath.section]
        
        cell.imageBook?.image = UIImage()   // Add grey frame to make loading prettier
        
        if let url = book.imageUrl {
            cell.imageBook?.load(url: url)
        }
        
        cell.topLabel?.text = book.title
        cell.bottomLabel?.text = book.author
        /*
        cell.addTapGestureRecognizer { _ in
            let bookDetailViewController = BookDetailViewController(withBookDetailViewModel: BookDetailViewModel(book: book))
            self.navigationController?.pushViewController(bookDetailViewController, animated: true)
        }
        */
        return cell
    }
}

private extension RentalsViewController {
    func setupBindings() {
        rentalsViewModel.rentedBooks.producer.startWithValues { [unowned self] _ in
            self.rentalsView.tableRentals.reloadData()
        }
    }
}
