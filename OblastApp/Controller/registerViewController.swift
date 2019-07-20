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
    
//
//    let ref = Database.database().reference(withPath: "oblast")
//    let rootRef = Database.database().reference()

    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func didTapSignUp(sender: UIButton) {
       
        let signUpManager = AuthenticationManager()
        if let email = emailField.text, let password = passwordField.text {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                } else {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }
        }
        
    
        
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
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

