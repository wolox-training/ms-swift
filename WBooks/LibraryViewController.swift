//
//  ViewController.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

final class LibraryViewController: UIViewController {
  
    private let libraryView: LibraryView = LibraryView.loadFromNib()!

    static let spacingBetweenCells: CGFloat = 10
    
    // MVVM
    private let libraryViewModel: LibraryViewModel = LibraryViewModel()
    
    override func loadView() {
        view = libraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: LibraryCell.xibFileCellName, bundle: nil)
        libraryView.tableBooks.register(nib, forCellReuseIdentifier: LibraryCell.xibFileCellName)
        libraryView.tableBooks.delegate = self  
        libraryView.tableBooks.dataSource = self
        
        libraryViewModel.loadBooks()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return libraryViewModel.bookArray.count
   //     return 8    // Hard coded for debugging
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.xibFileCellName, for: indexPath) as? LibraryCell else {
            print("Error on dequeueReusableCell")
            return UITableViewCell()
        }

        // Fill in the cell with info
     
        cell.imageBook.image = UIImage(named: libraryViewModel.getBookImageAtIndex(index: indexPath.section))
        cell.topLabel.text = libraryViewModel.getBookTitleAtIndex(index: indexPath.section)
        cell.botLabel.text = libraryViewModel.getBookAuthorAtIndex(index: indexPath.section)
        
 
        
        return cell
    }
}
