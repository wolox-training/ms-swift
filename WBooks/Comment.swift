//
//  Comment.swift
//  WBooks
//
//  Created by Matías David Schwalb on 05/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var bookID: Int
    var username: String
    var image: String
    var comment: String
}
