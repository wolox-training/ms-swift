//
//  CommentDB.swift
//  WBooks
//
//  Created by Matías David Schwalb on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

struct CommentDB {
    static var commentArray: [Comment] = [Comment(bookID: 1, username: "username 1", image: "img_user1", comment: "comment1"),
                                          Comment(bookID: 1, username: "username 2", image: "img_user2", comment: "comment 2"),
                                          Comment(bookID: 1, username: "username 3", image: "img_user1", comment: "comment 3"),
                                          Comment(bookID: 1, username: "username 4", image: "img_user2", comment: "comment 4")]
    
  //  static var commentArray: [Comment] = []
    
    static func getCommentsUsingBookID(bookID: Int) -> [Comment] {
        var comments: [Comment] = []
        
        for index in 0..<CommentDB.commentArray.count where CommentDB.commentArray[index].bookID == bookID {
            comments.append(CommentDB.commentArray[index])
        }
        
        return comments
    }
}

struct CommentFromJSON: Codable {
    let book: Book
    let content: String
    let id: Int
    let user: User
}
