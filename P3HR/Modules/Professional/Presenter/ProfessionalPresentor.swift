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
    
    func getProfile (completion : @escaping (Profile?, Error?) -> ()) {
        let profileID = UserDefaults.standard.string(forKey: "profileID")!
        let url = RequestType.profile.url + "/" + profileID
        NetworkManager<Profile>.get(forURL: url) { (response, error) in
            completion (response, error)
        }
    }

}
