//
//  Profile.swift
//  P3HR
//
//  Created by Ankit Angra on 07/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

class Profile : Root {
    var name : String?
    var email : String?
    var user : ProfessionalUser?
}

class ProfessionalUser : BaseModel {
    var province : String?
    var city : String?
}
