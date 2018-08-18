//
//  Profile.swift
//  P3HR
//
//  Created by Ankit Angra on 07/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

class Professional : Root {
    var name : String?
    var email : String?
    var user : ProfessionalProfile?
}

class ProfessionalProfile : BaseModel {
    var province : String?
    var city : String?
    var organization : String?
    var department : String?
    var healthProfessional : String?
    var status : Int = 0
    var firstName : String?
    var lastName : String?
    var email : String?
    var imageURL : String?
    var phoneNumber : Int = 0
}
