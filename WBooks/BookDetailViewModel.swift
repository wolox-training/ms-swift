//
//  BookDetailViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

final class BookDetailViewModel {

    var bookID: Int
    
    init(bookID: Int) {
        self.bookID = bookID-1
    }
}
