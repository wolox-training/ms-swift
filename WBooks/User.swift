//
//  User.swift
//  WBooks
//
//  Created by Matías David Schwalb on 06/06/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct User: Codable {
    let username: String
    let id: Int
    let image: String
}

extension User: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<User> {
        return curry(User.init)
            <^> json <| "username"
            <*> json <| "id"
            <*> json <| "image"
    }
}
