//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by Matías David Schwalb on 28/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import UIKit

final class LibraryViewModel {
    init() {
        // Does my class inherit from another superclass?
        // If no, should my initializer do something?
 /*
        // Hardcoded initial data array
        for index in 0...5 {
            let myTitle = "title number " + String(index)
            let myAuthor = "author number " + String(index)
            let myImageName = "img_book" + String(index + 1)
//            addBookToArray(title: myTitle, author: myAuthor, imageName: myImageName)
   */     }
    
    var bookArray: [Book] = []
    
    func booksLoaded(books: [Book]) {
        bookArray = books
    }

    func loadBooks() {
        let repository = BookRepository()
        
        let onSuccess = { books in
            print(books)
          //  self.booksLoaded(books: books)
        }
        
        let onError = { error in
            print(error)
        }
        
        repository.fetchBooks(onSuccess: onSuccess, onError: onError)
    }
/*
    func addBookToArray(id: Int, title: String, author: String, genre: String, year: String, image: String) {
        
        let book: Book = Book(id: id, title: title, author: author, image: image)
        
        bookArray.append(book)
    }
 */
    
    func countMembersInBookArray() -> Int {
        return bookArray.count
    }
    
    func getBookTitleAtIndex(index: Int) -> String {
        return bookArray[index].title
    }
    
    func getBookAuthorAtIndex(index: Int) -> String {
        return bookArray[index].author
    }
    
    func getBookImageAtIndex(index: Int) -> String {
        return bookArray[index].image
    }
}

