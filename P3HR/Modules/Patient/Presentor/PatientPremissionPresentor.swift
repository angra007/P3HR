//
//  PatientPremissionPresentor.swift
//  P3HR
//
//  Created by Ankit Angra on 05/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation


protocol PatientPremissionDelegate : class {
    func didReceiveData ()
    func didReceiveError ( _ error : Error)
}

extension PatientPremissionDelegate {
    func showActivityIndicator () {
        ActivityIndicatorManager.showActivityIndicator()
    }
    
    func hideActivityIndicator () {
        ActivityIndicatorManager.dismissActivityIndicator()
    }
}

class PatientPremissionPresentor {
    
    private var healthProfessional = [HealthProfessional] ()
    
    weak var delegate : PatientPremissionDelegate!
    
    init(withDelegate delegate : PatientPremissionDelegate) {
        self.delegate = delegate
    }
    
    func filter (withQuery query : String) {
        
        var dict = [String : String] ()
        dict ["query"] = query
        
        self.delegate.showActivityIndicator ()
        NetworkManager<HealthProfessionalSearchResult>.post(forRequest: .search, withData: dict as [String : AnyObject]) { (healthProfessional, error) in
            self.delegate.hideActivityIndicator ()
            if let error = error {
                self.delegate.didReceiveError(error)
            }
            else {
                self.healthProfessional = healthProfessional!.users
                self.delegate.didReceiveData()
            }
        }
    }
    
    func numberOfItems () -> Int {
        return healthProfessional.count
    }
    
    func item (atIndex index : Int) -> HealthProfessional {
        return healthProfessional [index]
    }
    
    
}
