//
//  AuthenticationManager.swift
//  OblastApp
//
//  Created by Jackie on 6/18/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit
import FirebaseAuth


class AuthenticationManager: NSObject {

    static let sharedInstance = AuthenticationManager()
    
    
    var loggedIn = false
    var userName: String?
    var userId: String?
    
    func didLogIn(user: User) {
        AuthenticationManager.sharedInstance.userName = user.displayName
        AuthenticationManager.sharedInstance.loggedIn = true
        AuthenticationManager.sharedInstance.userId = user.uid
        
    }
    
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    
    
    
    

}
