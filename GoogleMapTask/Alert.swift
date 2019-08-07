//
//  Alert.swift
//  GoogleMapTask
//
//  Created by jets on 12/4/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    
    func showAlert(title: String, message: String, actions: [(title: String, action: () -> Void)]?) {
        let viewController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                let alertAction = UIAlertAction(title: action.title, style: .default) { _ in
                    action.action()
                }
                alert.addAction(alertAction)
            }
        } else {
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
        }
        viewController?.present(alert, animated: true, completion: nil)
    }
}
