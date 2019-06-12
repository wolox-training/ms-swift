//
//  CommentDB.swift
//  WBooks
//
//  Created by Matías David Schwalb on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

struct CommentDB {
/*
    static var commentArray: [CommentWithLoadedCheck] = []
    
    static var loadedFromAPI: Bool = false
    
    static func getCommentsUsingBookID(bookID: Int) -> [Comment] {
        var comments: [Comment] = []
        
        for index in 0..<CommentDB.commentArray.count where CommentDB.commentArray[index].comment.bookID == bookID {
            comments.append(CommentDB.commentArray[index].comment)
        }
        
        return comments
    }
    
}

struct CommentWithLoadedCheck {
    var loadedFromAPI: Bool = false
    var comment: Comment = Comment(bookID: -1, username: "", image: "", comment: "")
}

struct CommentFromJSON: Codable {
    var book: Book
    var content: String
    var id: Int
    var user: User
    
    func loadFromJSONToDataBase() {
        CommentDB.commentArray.append(CommentWithLoadedCheck(loadedFromAPI: true, comment: Comment(bookID: book.id, username: user.username, image: user.image, comment: content)))
    }*/
}
