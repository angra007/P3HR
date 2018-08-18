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
    case UNKNOWN_ERROR
    case RECORD_NAME_ERROR
    case RECORD_DESCRIPTION_ERROR
    case RECORD_ATTACHMENT_ERROR
    
    case USER_VERIFICATION_ERROR
    
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
        case .RECORD_NAME_ERROR:
            return "Please enter name of record"
        case .RECORD_DESCRIPTION_ERROR:
            return "Please enter description of record"
        case .RECORD_ATTACHMENT_ERROR:
            return "Please selecte an attachment for the record"
        case .USER_VERIFICATION_ERROR:
            return "Your a not verified yet. Please contact your orgaization"
        case .UNKNOWN_ERROR:
            return "Unknown Error"
        }
    }
}
