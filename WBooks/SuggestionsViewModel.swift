//
//  SuggestionsViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 19/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import WolmoCore
import Result

class SuggestionsViewModel {
    
    private let mutableSuggestedBooks = MutableProperty<[Book]>([])
    public var suggestedBooks: Property<[Book]>
    
    private let bookRepository: WBookRepositoryType
    
    init(bookRepository: WBookRepositoryType = NetworkingBootstrapper.shared.createWBooksRepository()) {
        self.bookRepository = bookRepository
        
        suggestedBooks = Property(mutableSuggestedBooks)
        mutableSuggestedBooks <~ bookRepository.fetchSuggestions()
            .flatMapError { _ in SignalProducer<[Book], NoError>.empty }
    }
    
    public func updateRepository() {
        suggestedBooks = Property(mutableSuggestedBooks)
        mutableSuggestedBooks <~ bookRepository.fetchSuggestions()
            .flatMapError { _ in SignalProducer<[Book], NoError>.empty }
    }
}
