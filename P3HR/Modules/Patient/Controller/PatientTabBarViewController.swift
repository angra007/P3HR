//
//  PatientTabBarViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 12/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PatientTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let patientHomeViewController = UIStoryboard.patientStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.patientHome.rawValue)
        let patientRecordViewController = UIStoryboard.patientStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.patientRecord.rawValue)
        let patientProfileViewController = UIStoryboard.patientStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.patientProfile.rawValue)
       
        
        let tabOneBarItem1 = UITabBarItem.init(title: "Notes", image: UIImage(named : "notes"), tag: 0)
        let tabOneBarItem2 = UITabBarItem.init(title: "Record", image: UIImage(named : "record"), tag: 0)
        let tabOneBarItem3 = UITabBarItem.init(title: "Profile", image: UIImage(named : "profile"), tag: 0)
        
        patientHomeViewController.tabBarItem = tabOneBarItem1
        patientRecordViewController.tabBarItem = tabOneBarItem2
        patientProfileViewController.tabBarItem = tabOneBarItem3
        
        self.viewControllers = [patientHomeViewController, patientRecordViewController, patientProfileViewController]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
