//
//  AddNewViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 18/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import Networking
import Argo

final class AddNewViewModel {
    let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    public func printBook() {
        print(book)
    }
}
