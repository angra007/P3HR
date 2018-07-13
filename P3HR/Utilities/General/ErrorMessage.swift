//
//  ErrorMessage.swift
//  P3HR
//
//  Created by Ankit Angra on 13/07/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation



enum ErrorMessage {
    case REGISTRATION_EMAIL_ERROR
    case REGISTRATION_NAME_ERROR
    case REGISTRATION_PASSWORD_ERROR
    case REGISTRATION_CONFIRM_PASSWORD_ERROR
    
    var message : String {
        switch self {
        case .REGISTRATION_NAME_ERROR:
            return "Please enter your name."
        case .REGISTRATION_EMAIL_ERROR:
            return "Please enter your email."
        case .REGISTRATION_PASSWORD_ERROR:
            return "Please enter your passowrd."
        case .REGISTRATION_CONFIRM_PASSWORD_ERROR:
            return "Password donot match."
        }
    }
}
