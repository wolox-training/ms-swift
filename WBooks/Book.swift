//
//  Book.swift
//  WBooks
//
//  Created by Matías David Schwalb on 31/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Book {
    
    // MARK: - Properties
    let status: String
    let id: Int
    let author: String
    let title: String
    let imageUrl: URL?
    let year: String
    let genre: String
    
    init(status: String, id: Int, author: String, title: String, image: String?, year: String, genre: String) {
        self.status = status
        self.id = id
        self.author = author
        self.title = title
        self.imageUrl = image != nil ? URL(string: image!) : nil
        self.year = year
        self.genre = genre
    }
}

extension Book: Argo.Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Book> {
        return curry(Book.init)
            <^> json <| "status"
            <*> json <| "id"
            <*> json <| "author"
            <*> json <| "title"
            <*> json <|? "image"
            <*> json <| "year"
            <*> json <| "genre"
    }
    
}
