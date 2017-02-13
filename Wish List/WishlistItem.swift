//
//  WishListItem.swift
//  Wish List
//
//  Created by Annie Tung on 2/12/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import Foundation

class WishListItem {
    let item: String
    let addedByUser: String
    let completed: Bool
    
    init(item: String, addedByUser: String, completed: Bool) {
        self.item = item
        self.addedByUser = addedByUser
        self.completed = completed
    }
}
