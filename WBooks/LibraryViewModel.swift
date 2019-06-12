//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import WolmoCore
import Result

class LibraryViewModel {
    
    private let mutableBooks = MutableProperty<[Book]>([])
    public var books: Property<[Book]>
    
    private let bookRepository: WBookRepositoryType
    
    init(bookRepository: WBookRepositoryType = NetworkingBootstrapper.shared.createWBooksRepository()) {
        self.bookRepository = bookRepository
        
        books = Property(mutableBooks)
        mutableBooks <~ bookRepository.fetchEntities()
            .flatMapError { _ in SignalProducer<[Book], NoError>.empty }
    }
}
