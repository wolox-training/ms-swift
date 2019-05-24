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
    
    let spacingBetweenCells: CGFloat = 10
    
    // Hard coded data array
    private var bookArray: Array = [["title": "When the doves disappeared", "author": "Timothy Cross", "img": "img_book1"], ["title": "When the doves disappearedasdasdasdasdasasdasdas", "author": "Sofi Oksanen", "img": "img_book2"], ["title": "The best book in the world", "author": "Peter Stjerstrom", "img": "img_book3"], ["title": "Be creative", "author": "unknown", "img": "img_book4"], ["title": "Redesign the web", "author": "Wolox", "img": "img_book5"], ["title": "Yellow", "author": "Matias Schwalb", "img": "img_book6"]]
    
    override func loadView() {
        view = libraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
        libraryView.tblBooks.register(nib, forCellReuseIdentifier: "MyCustomCell")
        libraryView.tblBooks.delegate = self
        libraryView.tblBooks.dataSource = self
        
  //      libraryView.tblBooks.estimatedRowHeight = 68.0
   //     libraryView.tblBooks.rowHeight = UITableViewAutomaticDimension
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookArray.count
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
        return spacingBetweenCells
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    // Cell generator
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? MyCustomCell else {
            print("Error on dequeueReusableCell")
            return UITableViewCell()
        }

        // Fill in the cell with info
        
        let dict = bookArray[indexPath.section]

        cell.imageBook.image = UIImage(named: dict["img"]!)
        cell.topLabel.text = dict["title"]
        cell.botLabel.text = dict["author"]
        
        return cell
    }
    
}
