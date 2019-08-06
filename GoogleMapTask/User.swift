//
//  File.swift
//  GoogleMapTask
//
//  Created by jets on 12/4/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    let uid: String
    let email: String
    let userName : String
    let password : String
    
    init(uid: String, email: String, userName: String, password: String) {
        self.uid = uid
        self.email = email
        self.userName = userName
        self.password = password
    }
}
