//
//  TableViewHelper.swift
//  phostagram-ios
//
//  Created by Ankit Angra on 23/09/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import Foundation
import UIKit

protocol ResuableView : class  {
    
}

extension ResuableView where Self : UIView {
    static var reuseIdentifier : String {
        return String (describing: self)
    }
}
extension UITableViewCell : ResuableView {
    
}

protocol  NibLoadableView : class {
    
}
extension NibLoadableView where Self : UIView {
    static var nibName : String {
        return String (describing: self)
    }
}

extension UITableView {
    func register <T : UITableViewCell> (_ : T.Type) where T:ResuableView, T : NibLoadableView {
        let nib = UINib (nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    
    func dequeuResuableCell <T : UITableViewCell> (forIndexPath indexPath : IndexPath) -> T where T:ResuableView  {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath ) as? T else {
            fatalError("Could not degue cell with identifier : \(T.reuseIdentifier)")
        }
        return cell
    }
}


