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
    func postRent(book: Book) -> SignalProducer<Void, RepositoryError>
    func postNewBook(book: Book) -> SignalProducer<Void, RepositoryError>
    func fetchRentedBooks() -> SignalProducer<[RentedBook], RepositoryError>
}

class WBookRepository: AbstractRepository, WBookRepositoryType {
    
    private static let EntitiesPath = "books"
    private static let CommentsPath = "books/$book_id/comments"
    private static let PostRentPath = "users/8/rents"
    private static let PostNewBookPath = "books"
    private static let RentedBookPaths = "users/$user_id/rents"
    
    public func postRent(book: Book) -> SignalProducer<Void, RepositoryError> {
        let path = WBookRepository.PostRentPath
        let parameters = book.asDictionaryForRenting()

        return performRequest(method: .post, path: path, parameters: parameters) { _ in
            Result(value: ())
        }
    }
    
    public func postNewBook(book: Book) -> SignalProducer<Void, RepositoryError> {
        let path = WBookRepository.PostNewBookPath
        let parameters = book.asDictionaryForAddingNew()
        return performRequest(method: .post, path: path, parameters: parameters) { _ in
            Result(value: ())
        }
    }
    
    public func fetchComments(book: Book) -> SignalProducer<[Comment], RepositoryError> {
        let path = WBookRepository.CommentsPath.replacingOccurrences(of: "$book_id", with: String(book.id))
        return performRequest(method: .get, path: path) {
            decode($0).toResult()
        }
    }
    
    public func fetchRentedBooks() -> SignalProducer<[RentedBook], RepositoryError> {
        let path = WBookRepository.RentedBookPaths.replacingOccurrences(of: "$user_id", with: "8")
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
