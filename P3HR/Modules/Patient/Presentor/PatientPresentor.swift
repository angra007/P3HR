//
//  PatientPresentor.swift
//  P3HR
//
//  Created by Ankit Angra on 13/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation


protocol PatientPresentorDelegate : class {
    
}

extension PatientPresentorDelegate {
    func showActivityIndicator () {
        ActivityIndicatorManager.showActivityIndicator()
    }
    
    func hideActivityIndicator () {
        ActivityIndicatorManager.dismissActivityIndicator()
    }
}

class PatientPresentor {
    
    var delegate : PatientPresentorDelegate!
    
    func createRecord (withData data : [String : AnyObject], completion : @escaping (Bool, Error?) -> () ) {
        NetworkManager <Root>.post(forRequest: .record, withData: data) { [weak self] (response, error) in
            self?.delegate.hideActivityIndicator()
            if response?.status == 200 {
                completion (true, nil)
            }
            else if let error = error {
                completion (false, error)
            }
            else {
                completion (false, nil)
            }
        }
    }
    
    func uploadDocument (withURL url : URL, completion : @escaping (Attachment?, Error?) -> ()) {
        delegate.showActivityIndicator()
        NetworkManager<Attachment>.upload(forRequest: .recordAttachment, withURL: url) { (response, errror) in
            completion (response, errror)
        }
    }
    
    func getRecords (completion : @escaping (Records,Error?) -> ()) {
        delegate.showActivityIndicator()
        
        let profileID = UserDefaults.standard.string(forKey: "profileID")!
        let url = RequestType.record.url + "/" + profileID
        
        NetworkManager<Records>.get(forURL: url) { [weak self] (response, error) in
            self?.delegate.hideActivityIndicator()
            if error == nil {
                completion (response!, nil)
            }
        }
    }
    
    func getProfile (completion : @escaping (Patient?, Error?) -> ()) {
        let profileID = UserDefaults.standard.string(forKey: "profileID")!
        let url = RequestType.profile.url + "/" + profileID
        delegate.showActivityIndicator()
        NetworkManager<Patient>.get(forURL: url) { [weak self] (response, error) in
            self?.delegate.hideActivityIndicator()
            if response?.status == 200 {
                completion (response, error)
            }
            else {
                completion (nil, error)
            }
            
            
        }
    }
    
}
