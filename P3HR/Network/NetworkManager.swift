//
//  NetworkManager.swift
//  TopBantz
//
//  Created by Ankit Angra on 25/04/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager <T : BaseModel> {
    
    class func handleResponse ( response : DataResponse<T> ) -> (T?, Error?){
        switch(response.result) {
        case .success(_):
            if let result = response.result.value {
                return (result, nil)
            }
            else {
                let status = 404
                let message = "Unknown Error"
                let error = NSError.init(domain: message, code: status, userInfo: nil)
                return (nil, error)
            }
        case .failure(_):
            return (nil, response.result.error)
        }
    }
    
    class func getWithoutToken (forRequest request : RequestType,completion: @escaping (T?,Error?) -> Void)   {
        let url = request.url
        Alamofire.request(url).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func postWithoutToken (forRequest request : RequestType, withData data : Parameters, completion:  @escaping (T?,Error?) -> Void)   {
        let url = request.url
        Alamofire.request(url,  parameters: data).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func get (forRequest request : RequestType, completion : @escaping (Any?,Error?) -> Void) {
        let url = request.url
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.request(url, headers: headers).responseJSON { (response) -> Void in
            //handleResponse(response:response , completion: completion)
        }
    }
    
    class func post (forRequest request : RequestType, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        let url = request.url
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token

        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            //handleResponse(response:response , completion: completion)
        }
    }
    
    class func post (forURL url : String, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token

        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            //handleResponse(response:response , completion: completion)
        }
    }
    
    class func put (forURL url : String, completion:  @escaping (Any?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token

        Alamofire.request(url, method: .put, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            //handleResponse(response:response , completion: completion)
        }
    }
}
