//
//  ActivityIndicatorManager.swift
//  phostagram-ios
//
//  Created by Ankit Angra on 27/09/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import Foundation
import SVProgressHUD

class ActivityIndicatorManager {
    
    class func showActivityIndicator () {
        SVProgressHUD.show()
    }
    
    class func dismissActivityIndicator () {
        SVProgressHUD.dismiss ()
    }
    
}
