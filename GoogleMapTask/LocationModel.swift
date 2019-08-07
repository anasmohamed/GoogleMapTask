//
//  Location.swift
//  GoogleMapTask
//
//  Created by jets on 12/4/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import Foundation
import UIKit

class LocationModel {
    
    var country : String = ""
    var city : String = ""
    init() {
        
    }
    
    init(city :String, country:String) {
        self.city = city
        self.country = country
    }
}
