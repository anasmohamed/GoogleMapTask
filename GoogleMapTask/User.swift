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
    
    var uid: String = ""
    var email: String = ""
    var userName : String = ""
    var password : String = ""
    init() {
        
    }
    
    init(uid: String, email: String, userName: String, password: String) {
        self.uid = uid
        self.email = email
        self.userName = userName
        self.password = password
    }
}
