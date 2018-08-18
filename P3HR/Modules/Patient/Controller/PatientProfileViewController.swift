//
//  PatientProfileViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 12/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PatientProfileViewController: ParentViewController, PatientPresentorDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var provienceLabel: UILabel!
    
    var patientProfile : PatientProfile?
    let patientPresentor = PatientPresentor()
    
    @IBAction func didTapEditButton(_ sender: UIBarButtonItem) {
       
        let profileEditVC = UIStoryboard.patientStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.patientEditProfile.rawValue) as! PatientEditProfileViewController
        profileEditVC.patientProfile = patientProfile
        self.navigationController?.pushViewController(profileEditVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        patientPresentor.delegate = self
        
        patientPresentor.getProfile { [weak self](patitent, error) in
            if let patitent = patitent {
                self?.patientProfile = patitent.user!
                self?.nameLabel.text = patitent.user!.firstName! + " " + patitent.user!.lastName!
                self?.emailLabel.text = patitent.user!.email
                self?.cityLabel.text = patitent.user!.city
                self?.provienceLabel.text = patitent.user!.province
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
