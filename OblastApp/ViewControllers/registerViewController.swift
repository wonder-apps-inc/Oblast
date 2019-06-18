//
//  ViewController.swift
//  Faxtion Version 1- Single-View
//
//  Created by Egbert Sayers on 3/4/19.
//  Copyright © 2019 Egbert Sayers. All rights reserved.
//

import UIKit
import Firebase

class registerViewController: UIViewController {
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func didTapSignUp(sender: UIButton) {
        guard let name = nameField.text,
        let email = emailField.text,
        let password = passwordField.text,
        name.count > 0,
        email.count > 0,
        password.count > 0
            else {
                self.showAlert(message: "Enter a name, email and password")
        }
     
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                if error._code == AuthErrorCode.invalidEmail.rawValue {
                    self.showAlert(message: "Enter a valid email.")
                } else if error._code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    self.showAlert(message: "Email already in use.")
                } else {
                    self.showAlert(message: "Error: \(error.localizedDescription)")
                }
                print(error.localizedDescription)
                return
            }
        
                
                
            if let user = user {
                self.setUserName(user: user, name: name)
                
            }
        }
        
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Oblast", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func setUserName(user: User, name: String) {
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            AuthenticationManager.sharedInstance.didLogIn(user: user)
            self.performSegue(withIdentifier: "ShowChatsFromSignUp", sender: nil)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

