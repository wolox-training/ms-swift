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
    
    // Add private?
    private var usersArray : Array = [["title": "A little bird told me", "author": "Timothy Cross"], ["title": "When the doves disappeared", "author": "Sofi Oksanen"], ["title": "The best book in the world", "author": "Peter Stjerstrom"], ["title": "Be creative", "author": "unknown"], ["title": "Redesign the web", "author": "Wolox"], ["title": "Yellow", "author": "Matias Schwalb"]]
    private var imgArray : Array = ["img_book1", "img_book2", "img_book3", "img_book4", "img_book5", "img_book6"]
    
    override func loadView() {
        view = libraryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
        libraryView.tblBooks.register(nib, forCellReuseIdentifier: "MyCustomCell")
        libraryView.tblBooks.delegate = self
        libraryView.tblBooks.dataSource = self
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? MyCustomCell else {
            print("Error on dequeueReusableCell")
            return UITableViewCell()
        }
        
        // Fill in the cell with info
        
        let dict = usersArray[indexPath.row]
        
        cell.topLabel.font = UIFont.boldSystemFont(ofSize: 16)
        cell.botLabel.font = UIFont.italicSystemFont(ofSize: 12)
        cell.imageBook.image = UIImage(named: imgArray[indexPath.row])
        cell.topLabel.text = dict["title"]
        cell.botLabel.text = dict["author"]
        
        return cell
    }
    
}
