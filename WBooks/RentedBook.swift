//
//  RentedBook.swift
//  WBooks
//
//  Created by Matías David Schwalb on 18/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct RentedBook: Codable {
    let from: String
    let id: Int
    let user: RentedUser
    let to: String
    let book: Book
    
    init(from: String, id: Int, user: RentedUser, to: String, book: Book) {
        self.from = from
        self.id = id
        self.user = user
        self.to = to
        self.book = book
    }
}

struct RentedUser: Codable {
    let id: Int
    let username: String
    
    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
}

extension RentedUser: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<RentedUser> {
        return curry(RentedUser.init)
            <^> json <| "id"
            <*> json <| "username"
    }
}

extension RentedBook: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<RentedBook> {
        return curry(RentedBook.init)
            <^> json <| "from"
            <*> json <| "id"
            <*> json <| "user"
            <*> json <| "to"
            <*> json <| "book"
    }
}
