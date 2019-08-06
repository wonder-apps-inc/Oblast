//
//  User.swift
//  OblastApp
//
//  Created by Jackie on 8/5/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
