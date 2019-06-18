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
    private let bookRepository: WBookRepositoryType
    
    private let finishedPostingPipe = Signal<Void, RepositoryError>.pipe()
    public var finishedPostingSignal: Signal<Void, RepositoryError> {
        return finishedPostingPipe.output
    }
    
    init(book: Book, bookRepository: WBookRepositoryType = NetworkingBootstrapper.shared.createWBooksRepository()) {
        self.book = book
        self.bookRepository = bookRepository
    }
    
    public func printBook() {
        print(book)
    }
    
    public func postNewBook() {
        let postNewBookResult = bookRepository.postNewBook(book: book)
        postNewBookResult.producer.startWithResult { result in
            if result.value != nil {
                self.finishedPostingPipe.input.send(value: result.value!)
            }
            if result.error != nil {
                self.finishedPostingPipe.input.send(error: result.error!)
            }
        }
        
    }
}
