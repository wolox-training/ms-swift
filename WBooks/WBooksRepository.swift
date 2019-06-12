//
//  WBooksRepository.swift
//  WBooks
//
//  Created by Matías David Schwalb on 31/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Networking
import ReactiveSwift
import Argo
import Result

protocol WBookRepositoryType {
    func fetchEntities() -> SignalProducer<[Book], RepositoryError>
    func fetchComments(book: Book) -> SignalProducer<[Comment], RepositoryError>
}

class WBookRepository: AbstractRepository, WBookRepositoryType {
    
    private static let EntitiesPath = "books"
    private static let CommentsPath = "books/$book_id/comments"
    
    public func fetchComments(book: Book) -> SignalProducer<[Comment], RepositoryError> {
        let path = WBookRepository.CommentsPath.replacingOccurrences(of: "$book_id", with: String(book.id))
        return performRequest(method: .get, path: path) {
            decode($0).toResult()
        }
    }
    
    public func fetchEntities() -> SignalProducer<[Book], RepositoryError> {
        let path = WBookRepository.EntitiesPath
        return performRequest(method: .get, path: path) {
            decode($0).toResult()
        }
    }
    
}
