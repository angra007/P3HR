//
//  NetworkManager.swift
//  TopBantz
//
//  Created by Ankit Angra on 25/04/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager {
    
    class func handleResponse ( response : DataResponse <Any>, completion : @escaping (Any?,Error?) -> Void ) {
        switch(response.result) {
        case .success(_):
            if let result = response.result.value as? [String : AnyObject] {
                if response.response?.statusCode == 200 {
                    completion (result, nil)
                }
                else {
                    var status = 404
                    var message = "Unknown Error"
                    if let s = result ["status"] as? Int {
                        status = s
                    }
                    if let m = result ["message"] as? String {
                        message = m
                    }
                    let error = NSError.init(domain: message, code: status, userInfo: nil)
                    completion (nil, error)
                }
            }
            else {
                completion (nil, response.result.error)
            }
        case .failure(_):
            completion (nil, response.result.error)
        }
    }
    
    class func getWithoutToken (forRequest request : RequestType, completion : @escaping (Any?,Error?) -> Void) {
        let url = request.url
        Alamofire.request(url).responseJSON { (response) -> Void in
            handleResponse(response:response , completion: completion)
        }
    }
    
    class func postWithoutToken (forRequest request : RequestType, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        let url = request.url
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
            handleResponse(response:response , completion: completion)
        }
    }
    
    class func get (forRequest request : RequestType, completion : @escaping (Any?,Error?) -> Void) {
        let url = request.url
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.request(url, headers: headers).responseJSON { (response) -> Void in
            handleResponse(response:response , completion: completion)
        }
    }
    
    class func post (forRequest request : RequestType, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        let url = request.url
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token

        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            handleResponse(response:response , completion: completion)
        }
    }
    
    class func post (forURL url : String, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token

        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            handleResponse(response:response , completion: completion)
        }
    }
    
    class func put (forURL url : String, completion:  @escaping (Any?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token

        Alamofire.request(url, method: .put, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            handleResponse(response:response , completion: completion)
        }
    }
}
