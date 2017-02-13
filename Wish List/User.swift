//
//  User.swift
//  Wish List
//
//  Created by Annie Tung on 2/12/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import Foundation

class User {
    let uid: String
    let email: String
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
