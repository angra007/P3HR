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
    
    private func handleAuth (response : AuthModel? , error : Error?, completion : ((AuthModel?, Error?) -> ())) {
        self.delegate.hideActivityIndicator()
        if let error = error {
            completion (nil, error)
        }
        else if let result = response  {
            if let token = result.token, let id = result.id {
                UserDefaults.standard.set(token, forKey: "x-auth")
                UserDefaults.standard.set(id, forKey: "profileID")
                completion (result, nil)
            }
            else {
                let message = ErrorMessage.UNKNOWN_ERROR.message
                let status = 404
                let error = NSError.init(domain: message, code: status, userInfo: nil)
                completion (nil,error )
            }
        }
        else {
            let message = ErrorMessage.UNKNOWN_ERROR.message
            let status = 404
            let error = NSError.init(domain: message, code: status, userInfo: nil)
            completion (nil, error)
        }
    }
    
    func login (withEmail email : String, password : String, completion : @escaping (AuthModel?, Error?) -> ()) {
        delegate.showActivityIndicator()
        var dict = [String : String] ()
        dict ["email"] = email
        dict ["password"] = password
        NetworkManager<AuthModel>.postWithoutToken(forRequest: .login, withData: dict as [String : AnyObject]) { (response, error) in
            self.handleAuth(response: response, error: error, completion: completion)
        }
    }
    
    func register (withEmail email : String, password : String,type : String , firstName : String, secondName : String, completion : @escaping (AuthModel?, Error?) -> ()) {
        delegate.showActivityIndicator()
        var dict = [String : String] ()
        dict ["email"] = email
        dict ["password"] = password
        dict ["type"] = type
        dict ["firstName"] = firstName
        dict ["lastName"] = secondName
        
        NetworkManager <AuthModel>.postWithoutToken(forRequest: .registeration, withData: dict as [String : AnyObject]) { (response, error) in
            self.delegate.hideActivityIndicator()
            self.handleAuth(response: response, error: error, completion: completion)
        }
    }
}
