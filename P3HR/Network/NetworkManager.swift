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
        Alamofire.request(url, method: .post, parameters: data).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func get (forRequest request : RequestType, completion : @escaping (T?,Error?) -> Void) {
        let url = request.url
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")!
        headers ["x-auth"] = token
        Alamofire.request(url, headers : headers).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func get (forURL url : String, completion : @escaping (T?,Error?) -> Void) {
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")!
        headers ["x-auth"] = token
        Alamofire.request(url, headers : headers).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func post (forRequest request : RequestType, withData data : [String : AnyObject], completion:  @escaping (T?,Error?) -> Void) {
        let url = request.url
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func post (forURL url : String, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func patch (forRequest request : RequestType, withData data : [String : AnyObject], completion:  @escaping (T?,Error?) -> Void) {
        let url = request.url
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.request(url, method: .patch, parameters: data, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func patch (forURL url : String, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.request(url, method: .patch, parameters: data, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            let result  = handleResponse (response: response)
            completion (result.0, result.1)
        }
    }
    
    class func upload (forRequest request : RequestType, withURL url : URL, completion:  @escaping (T?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.upload(multipartFormData: { (form) in
            //form.append(data, withName: "image")            
            form.append(url, withName: "image")
        }, to: request.url,headers : headers, encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseObject { (response: DataResponse<T>) in
                    let result  = handleResponse (response: response)
                    completion (result.0, result.1)
                }
            case .failure(let encodingError):
                completion (nil,encodingError)
            }
        })
    }
    
    class func download (forURL url : String, completion:  @escaping (URL?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL:NSURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
            let PDF_name = NSString(string: url).lastPathComponent
            let fileURL = documentsURL.appendingPathComponent(PDF_name)
            
            return (fileURL!,[.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url, headers : headers, to: destination).downloadProgress(closure: { (prog) in }).response { response in
            if let error = response.error {
                return completion(nil, error as NSError)
            }
            if response.error == nil, let filePath = response.destinationURL?.path {
                let fileURL = URL(fileURLWithPath: filePath)
                completion(fileURL, nil)
            }
        }
    }
}
