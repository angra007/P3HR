//
//  File.swift
//  Sloggers
//
//  Created by Ankit Angra on 05/02/17.
//  Copyright © 2017 NewMediaTechies. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum StoryboardIdentifiers : String {
        case registeration = "RegistrationVC"
        case menu = "menuVC"
        case professionalMenu = "professionalMenuVC"
        case professionalProfile = "professionalProfileUpdateVC"
        
        
        
        case dashboardTabVC = "dashboardTabBar"
        case dashboard = "dash"
        case quizVC = "quizVC"
        case lorealPersonlListVC = "lorealPersonalListVC"
    }
    
    // LoginStoryboard
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func loginStoryboard () -> UIStoryboard {
        return  UIStoryboard(name: "LoginStoryboard", bundle: Bundle.main)
    }
    
    class func professionalStoryboard () -> UIStoryboard {
        return UIStoryboard(name: "ProfessionalStoryboard", bundle: Bundle.main)
    }
    
    class func patientStoryboard () -> UIStoryboard {
        return UIStoryboard(name: "PatientStoryboard", bundle: Bundle.main)
    }
}
