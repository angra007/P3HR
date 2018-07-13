//
//  AlertManager.swift
//  Homingos
//
//  Created by Ankit Angra on 04/10/17.
//  Copyright © 2017 Homingos. All rights reserved.
//

import UIKit

class AlertManager {
    
    class func showAlert(inViewController vc : UIViewController,withTitle title : String, message : String, cancelButtonTitle : String? = nil, destructiveButtonTitle : String? = nil, otherButtonTitles : [String]? = nil ,completion : ((Int) -> ())? = nil, cancelCompletion : (() -> ())? = nil ) {
        
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        if let cancelButton = cancelButtonTitle {
            if cancelButton.isBlank == false {
                // let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: .cancel, handler: nil)
                
                let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: .cancel, handler: { (action) in
                    cancelCompletion? ()
                })
                alertVC.addAction(cancelAction)
            }
        }
        
        if let desctictiveButton = destructiveButtonTitle {
            if desctictiveButton.isBlank == true {
                let desctructiveAction = UIAlertAction.init(title: cancelButtonTitle, style: .destructive, handler: nil)
                alertVC.addAction(desctructiveAction)
            }
        }
        
        if let otherButton = otherButtonTitles {
            for (index, item) in otherButton.enumerated() {
                let action = UIAlertAction.init(title: item, style: .default, handler: { action in
                    
                    if let completion = completion {
                        completion (index)
                    }
                })
                alertVC.addAction(action)
            }
        }
        
        if alertVC.actions.count == 0 {
            let cancelAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
        }
        
        vc.present(alertVC, animated: true, completion: nil)
    }
}


