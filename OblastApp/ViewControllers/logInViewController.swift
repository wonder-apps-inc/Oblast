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

class logInViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func didTapLogin(sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text, email.count > 0, password.count > 0 else {
            self.showAlert(message: "Enter an email and a password.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                if error._code == AuthErrorCode.userNotFound.rawValue {
                    self.showAlert(message: "There are no users with the specified account.")
                } else if error._code == AuthErrorCode.wrongPassword.rawValue {
                    self.showAlert(message: "Incorrect username or password.")
                } else {
                    self.showAlert(message: "Error: \(error.localizedDescription)")
                }
                print(error.localizedDescription)
                return
            }
            
            if let user = user {
                AuthenticationManager.sharedInstance.didLogIn(user: user)
                self.performSegue(withIdentifier: "ShowChatsFromLogin", sender: nil)
            }
        }
    }
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Oblast", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
        


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
