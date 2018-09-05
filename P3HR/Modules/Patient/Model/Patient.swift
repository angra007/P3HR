//
//  Patient.swift
//  P3HR
//
//  Created by Ankit Angra on 13/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

class Patient : Root {
    var email : String?
    var user : PatientProfile?
}

class PatientProfile : BaseModel {
    var province : String?
    var city : String?
    var firstName : String?
    var lastName : String?
    var email : String?
    var imagePath : String?
    var phoneNumber : Int = 0
}
