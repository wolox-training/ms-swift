//
//  Comment.swift
//  WBooks
//
//  Created by Matías David Schwalb on 05/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Comment: Codable {
    
    var user: User
    var id: Int
    var book: Book
    var content: String
    
    init(user: User, id: Int, book: Book, content: String) {
        self.user = user
        self.id = id
        self.book = book
        self.content = content
    }
}

extension Comment: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<Comment> {
        return curry(Comment.init)
            <^> json <| "user"
            <*> json <| "id"
            <*> json <| "book"
            <*> json <| "content"
    }
}
