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
    
    class func put (forURL url : String, withData data : [String : AnyObject], completion:  @escaping (Any?,Error?) -> Void) {
        
        var headers = [String: String]()
        let token = UserDefaults.standard.string(forKey: "x-auth")
        headers ["x-auth"] = token
        
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
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
    
    //    class func upload(data: Data, completion: @escaping (Any?, Error?) -> Void) {
    //        guard let data = UIImageJPEGRepresentation(image, 0.9) else {
    //            return
    //        }
    //
    //        let url = RequestType.profileUpload.url
    //
    //        Alamofire.upload(multipartFormData: { (form) in
    //            form.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
    //        }, to: url, encodingCompletion: { result in
    //            switch result {
    //            case .success(let upload, _, _):
    //                upload.responseString { response in
    //                    completion (response.value, nil)
    //                }
    //            case .failure(let encodingError):
    //                completion (nil,encodingError)
    //            }
    //        })
    //    }
    //
    //    class func uploadAudio (audioData : Data, audioNumber : Int, completion: @escaping (Any?, Error?) -> Void) {
    //        let url = RequestType.audio.url + "/chat-" + String (audioNumber) + "?messageType=AUDIO"
    //        Alamofire.upload(multipartFormData: { (form) in
    //            form.append(audioData, withName: "file", fileName: "record.m4a", mimeType: "audio/m4a")
    //        }, to: url, encodingCompletion: { result in
    //            switch result {
    //            case .success(let upload, _, _):
    //                upload.responseString { response in
    //                    completion (response.value, nil)
    //                }
    //            case .failure(let encodingError):
    //                completion (nil,encodingError)
    //            }
    //        })
    //    }
    //
    
}
