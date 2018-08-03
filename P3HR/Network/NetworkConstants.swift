//
//  NetworkConstants.swift
//  TopBantz
//
//  Created by Ankit Angra on 25/04/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

let BASE_URL = "http://ec2-52-15-234-252.us-east-2.compute.amazonaws.com/"

enum RequestType {
    case login
    case registeration

    var url : String {
        switch self {
        case .login:
            return BASE_URL + "auth/login"
        case .registeration:
            return BASE_URL + "auth/signup"
        }
    }
}


