//
//  BookDB.swift
//  WBooks
//
//  Created by Matías David Schwalb on 05/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

struct BookDB {
    
    static var bookArrayDB: [Book] = [] {
        didSet {
            // Sort books by bookID to access content using it's id
            self.bookArrayDB = bookArrayDB.sorted(by: { $0.id < $1.id })
        }
    }
    
    static var loadedFromAPI: Bool = false
}
