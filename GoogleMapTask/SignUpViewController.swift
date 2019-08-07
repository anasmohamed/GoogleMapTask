//
//  SignUp.swift
//  GoogleMapTask
//
//  Created by jets on 12/4/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import UIKit	
import Firebase


class SignUpViewController: UIViewController {
    @IBOutlet weak var textFieldSignUpEmail: UITextField!
    @IBOutlet weak var textFieldSignUpPassword: UITextField!
    @IBOutlet weak var textFieldSignUpUserName: UITextField!
    var ref: DatabaseReference!
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        guard
            let userName = textFieldSignUpUserName.text,
            let email = textFieldSignUpEmail.text,
            let password = textFieldSignUpPassword.text,
            userName.characters.count > 0,
            email.characters.count > 0,
            password.characters.count > 0
            else {
                return
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil {
                Auth.auth().signIn(withEmail: self.textFieldSignUpEmail.text!,
                                   password: self.textFieldSignUpPassword.text!)
            }
        }
        
        self.ref.child("users").child(user.uid).setValue(["username": userName,"password":password])
        user = User(uid: (Auth.auth().currentUser?.uid)!,email: email,userName: userName,password: password)
        homeVC.user = user
        self.present(homeVC, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func signInButtonDidTabbed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}




