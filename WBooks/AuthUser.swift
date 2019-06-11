//
//  AuthUser.swift
//  WBooks
//
//  Created by Matías David Schwalb on 31/05/2019.
//  Copyright © 2019 Wolox. All rights reserved.
//

import Foundation
import Networking

struct AuthUser: AuthenticableUser {
    let sessionToken: String? = "1"
}
