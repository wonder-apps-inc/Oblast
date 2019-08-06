//
//  homepage.swift
//  Faxtion Version 1- Single-View
//
//  Created by Egbert Sayers on 3/30/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

//

import UIKit
import Firebase
//NEED TO ADD CHECK TO SEE IF LOGGED IN, IF SO BYPASS LOGGIN IN AGAIN.
class logInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let loginToList = "LoginToList"
    
    @IBAction func didTapLogin(sender: UIButton) {
        performSegue(withIdentifier: loginToList, sender: nil)

       
    }
    
    @IBAction func signUpDidTouch(_ sender: AnyObject) {let alert = UIAlertController(title: "Register",
    message: "Register", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension logInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        if textField == textField {
            textField.resignFirstResponder()
        }
        return true
    }
}
