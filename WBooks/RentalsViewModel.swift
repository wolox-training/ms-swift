//
//  RentalsViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 18/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import WolmoCore
import Result

class RentalsViewModel {
    
    private let mutableRentedBooks = MutableProperty<[RentedBook]>([])
    public var rentedBooks: Property<[RentedBook]>
    
    private let bookRepository: WBookRepositoryType
    
    init(bookRepository: WBookRepositoryType = NetworkingBootstrapper.shared.createWBooksRepository()) {
        self.bookRepository = bookRepository
        
        rentedBooks = Property(mutableRentedBooks)
        mutableRentedBooks <~ bookRepository.fetchRentedBooks()
            .flatMapError { _ in SignalProducer<[RentedBook], NoError>.empty }
    }
    
    public func updateRepository() {
        mutableRentedBooks <~ bookRepository.fetchRentedBooks()
            .flatMapError { _ in SignalProducer<[RentedBook], NoError>.empty }
    }
}
