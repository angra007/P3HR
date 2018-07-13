//
//  StringHelper.swift
//  SurfSharing
//
//  Created by Ankit Angra on 03/11/17.
//  Copyright © 2017 Surf Sharing. All rights reserved.
//

import Foundation


extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return
                regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    //validate PhoneNumber
    var isPhoneNumber: Bool {
        let charcter  = CharacterSet.init(charactersIn: "+0123456789").inverted
        var filtered = ""
        let inputString = components(separatedBy: charcter)
        filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}
