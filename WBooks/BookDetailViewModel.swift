//
//  BookDetailViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 30/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import Networking
import Argo

final class BookDetailViewModel {

    public var book: Book
    private let bookRepository: WBookRepositoryType
    
    private let mutableComments = MutableProperty<[Comment]>([])
    public let comments: Property<[Comment]>
    
    private let finishedRentingPipe = Signal<Int, RepositoryError>.pipe()
    public var finishedRentingSignal: Signal<Int, RepositoryError> {
        return finishedRentingPipe.output
    }

    public var rentResult: SignalProducer<Void, RepositoryError> = SignalProducer<Void, RepositoryError> { (_, _) in
        return
    }

    private let changeLabelSignalPipe = Signal<String, NoError>.pipe()
    var changeLabelSignal: Signal<String, NoError> {
        return changeLabelSignalPipe.output
    }
    deinit {
        changeLabelSignalPipe.input.sendCompleted()
        finishedRentingPipe.input.sendCompleted()
    }
    
    init(book: Book, bookRepository: WBookRepositoryType = NetworkingBootstrapper.shared.createWBooksRepository()) {
        self.book = book
        self.bookRepository = bookRepository
        self.comments = Property(mutableComments)
        mutableComments <~ bookRepository.fetchComments(book: book)
            .flatMapError { _ in SignalProducer<[Comment], NoError>.empty }
    }
    
    func rent() {
        if checkBookStatus() { // ! added for debugging
            rentResult = bookRepository.postRent(book: book)
            rentResult.producer.startWithResult { result in
                if result.value != nil {
                    self.finishedRentingPipe.input.send(value: 1)
                    self.changeStatusOnBookStructure()
                } else if result.error != nil {
                    self.finishedRentingPipe.input.send(error: result.error!)
                }
            }
        } else {
            self.finishedRentingPipe.input.send(value: 2)
        }
    }
    
    func checkBookStatus() -> Bool {
        return book.status == "available"
    }

    func changeStatusOnBookStructure() {
        if book.status == "available" {
            book.status = "rented"
            changeLabelSignalPipe.input.send(value: "rented")
        } else if book.status == "rented" {
            book.status = "available"
            changeLabelSignalPipe.input.send(value: "available")
        }
    }
}
