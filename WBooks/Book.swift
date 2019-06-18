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

struct Book: Codable {
    
    // MARK: - Properties
    var status: String
    var id: Int
    var author: String
    var title: String
    var imageUrl: URL?
    var year: String
    var genre: String
    
    init(status: String, id: Int, author: String, title: String, image: String?, year: String, genre: String) {
        self.status = status
        self.id = id
        self.author = author
        self.title = title
        self.imageUrl = image != nil ? URL(string: image!) : nil
        self.year = year
        self.genre = genre
    }
    
    func asDictionaryForRenting() -> [String: Any] {
        let today: String = Date.getCurrentDateYYYY_MM_DD()
        let tomorrow: String = Date.addDaysToCurrentDateYYYY_MM_DD(daysToAdd: 1)
        let userID = 8  // userID assigned by trainer
        let bookID = self.id
        
        return ["userID": userID,
                "bookID": bookID,
                "from": today,
                "to": tomorrow] as [String: Any]
    }
    
    func asDictionaryForAddingNew() -> [String: Any] {
        return ["author": self.author,
                "title": self.title,
                "image": "some_url",
                "year": self.year,
                "genre": self.genre,
                "status": "available"]
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
