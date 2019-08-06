//
//  ViewController.swift
//  GoogleMapTask
//
//  Created by jets on 12/3/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   
    @IBAction func signUpDidTapped(_ sender: Any) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController
        self.present(signUpVC, animated: true, completion: nil)
    }
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        guard
            let email = textFieldLoginEmail.text,
            let password = textFieldLoginPassword.text,
            email.characters.count > 0,
            password.characters.count > 0
            else {
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
           self.present(homeVC, animated: true, completion: nil)
        
    }

}

