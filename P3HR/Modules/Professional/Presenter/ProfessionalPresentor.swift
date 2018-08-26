//
//  ProfessionalPresentor.swift
//  P3HR
//
//  Created by Ankit Angra on 03/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation


protocol ProfessionalPresentorDelegate : class {
    
}

extension ProfessionalPresentorDelegate {
    func showActivityIndicator () {
        ActivityIndicatorManager.showActivityIndicator()
    }
    
    func hideActivityIndicator () {
        ActivityIndicatorManager.dismissActivityIndicator()
    }
}

class ProfessionalPresentor {
    
    init(withDelegate delegate : ProfessionalPresentorDelegate) {
        self.delegate = delegate
    }
    
    private weak var delegate : ProfessionalPresentorDelegate!
    
    func getDefaults (completion : @escaping (ConfigurationDetails?, Error?) -> ()) {
        NetworkManager<ConfigurationDetails>.getWithoutToken (forRequest: .defaults) { (response, error) in
            completion (response, error)
        }
    }
    
    func getProfile (completion : @escaping (Professional?, Error?) -> ()) {
        let profileID = UserDefaults.standard.string(forKey: "profileID")!
        let url = RequestType.profile.url + "/" + profileID
        NetworkManager<Professional>.get(forURL: url) { (response, error) in
            completion (response, error)
        }
    }
    
    func verifyCode (_ code : String, completion : @escaping (Bool?, Error?) -> ()) {
        let profileID = UserDefaults.standard.string(forKey: "profileID")!
        var data = [String: AnyObject] ()
        data ["otp"] = code as AnyObject
        data ["id"] = profileID as AnyObject
        self.delegate.showActivityIndicator()
        NetworkManager<Code>.post(forRequest: .verifyCode, withData: data) { [unowned self] (code, error) in
            self.delegate.hideActivityIndicator()
            if let error = error {
                completion (nil, error)
            }
            else {
                if code?.message == "User Verified" {
                    completion (true, nil)
                }
                else {
                    completion (false, nil)
                }
            }
        }
    }
    
    func resendCode (completion : @escaping (Bool?, Error?) -> ()) {
        let profileID = UserDefaults.standard.string(forKey: "profileID")!
        let url = RequestType.resendCode.url + "/" + profileID
        
        self.delegate.showActivityIndicator()
        NetworkManager<Code>.get(forURL: url) { [unowned self](code, error) in
            self.delegate.hideActivityIndicator()
            if let error = error {
                completion (nil, error)
            }
            else {
                if code?.message == "Email Sen" {
                    completion (true, nil)
                }
                else {
                    completion (false, nil)
                }
            }
        }
    }
    
}
