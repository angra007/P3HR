//
//  AuthPresentor.swift
//  P3HR
//
//  Created by Ankit Angra on 02/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation


protocol AuthDelegate : class {
}

extension AuthDelegate {
    func showActivityIndicator () {
        ActivityIndicatorManager.showActivityIndicator()
    }
    
    func hideActivityIndicator () {
        ActivityIndicatorManager.dismissActivityIndicator()
    }
}

class AuthPresentor {
    
    init(withDelegate delegate : AuthDelegate) {
        self.delegate = delegate
    }
    
    private weak var delegate : AuthDelegate!
    
    private func handleAuth (response : Any? , error : Error?, completion : ((Bool, Error?) -> ())) {
        self.delegate.hideActivityIndicator()
        if let error = error {
            completion (false, error)
        }
        else if let result = response as? [String : AnyObject] {
            if let token = result ["token"] as? String, let id =  result ["id"] as? String{
                UserDefaults.standard.set(token, forKey: "x-auth")
                UserDefaults.standard.set(id, forKey: "profileID")
                completion (true, nil)
            }
            else {
                let message = ErrorMessage.UNKNOWN_ERROR.message
                let status = 404
                let error = NSError.init(domain: message, code: status, userInfo: nil)
                completion (false,error )
            }
        }
        else {
            let message = ErrorMessage.UNKNOWN_ERROR.message
            let status = 404
            let error = NSError.init(domain: message, code: status, userInfo: nil)
            completion (false, error)
        }
    }
    
    func login (withEmail email : String, password : String, completion : @escaping (Bool, Error?) -> ()) {
        delegate.showActivityIndicator()
        var dict = [String : String] ()
        dict ["email"] = email
        dict ["password"] = password
        NetworkManager.postWithoutToken(forRequest: .login, withData: dict as [String : AnyObject]) { (response, error) in
            self.handleAuth(response: response, error: error, completion: completion)
        }
    }
    
    func register (withEmail email : String, password : String,type : String ,completion : @escaping (Bool, Error?) -> ()) {
        delegate.showActivityIndicator()
        var dict = [String : String] ()
        dict ["email"] = email
        dict ["password"] = password
        dict ["type"] = type
        NetworkManager.postWithoutToken(forRequest: .registeration, withData: dict as [String : AnyObject]) { (response, error) in
            self.delegate.hideActivityIndicator()
            self.handleAuth(response: response, error: error, completion: completion)
        }
    }
}
