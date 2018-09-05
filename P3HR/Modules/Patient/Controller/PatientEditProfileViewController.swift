//
//  PatientEditProfileViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 13/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PatientEditProfileViewController: ParentViewController, PatientPresentorDelegate {

    private let FIRST_NAME_TAG = 10001
    private let LAST_NAME_TAG = 10002
    private let EMAIL_TAG = 10003
    private let PHONE_NUMBER_TAG = 10004
    private let CITY_TAG = 10005
    private let PROVIENCE_TAG = 10006
    
    let patientPresentor = PatientPresentor()
    var patientProfile : PatientProfile!
    
    @IBOutlet weak var firstNameTextfield: P3HRTextField! {
        didSet {
            firstNameTextfield.delegate = self
            firstNameTextfield.tag = FIRST_NAME_TAG
            firstNameTextfield.text = patientProfile.firstName
        }
    }
    
    @IBOutlet weak var lastNameTextfield: P3HRTextField! {
        didSet {
            lastNameTextfield.delegate = self
            lastNameTextfield.tag = LAST_NAME_TAG
            lastNameTextfield.text = patientProfile.lastName
        }
    }
    
    @IBOutlet weak var emailTextfield: P3HRTextField! {
        didSet {
            emailTextfield.delegate = self
            emailTextfield.tag = EMAIL_TAG
            emailTextfield.text = patientProfile.email
            emailTextfield.textColor = UIColor.lightGray
            emailTextfield.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet weak var phoneNumberTextField: P3HRTextField! {
        didSet {
            phoneNumberTextField.delegate = self
            phoneNumberTextField.tag = PHONE_NUMBER_TAG
        }
    }
    
    @IBOutlet weak var cityTextField: P3HRTextField! {
        didSet {
            cityTextField.delegate = self
            cityTextField.tag = CITY_TAG
            cityTextField.text = patientProfile.city
        }
    }
    
    @IBOutlet weak var provienceTextField: P3HRTextField! {
        didSet {
            provienceTextField.delegate = self
            provienceTextField.tag = PROVIENCE_TAG
            provienceTextField.text = patientProfile.province
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        patientPresentor.delegate = self
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.firstNameTextfield.becomeFirstResponder()
        
        let barButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector (didTapDoneButton))
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    @objc func didTapDoneButton () {
        
        let profileID = UserDefaults.standard.string(forKey: "profileID")!
        var dict = [String : String] ()
        dict ["profileID"] = profileID
        dict ["firstName"] = firstNameTextfield.text
        dict ["lastName"] = lastNameTextfield.text
        dict ["email"] = emailTextfield.text
        dict ["phoneNumber"] = phoneNumberTextField.text
        dict ["city"] = cityTextField.text
        dict ["provience"] = provienceTextField.text
        
        patientPresentor.updateProfile(withDict: dict) { [unowned self] (_, error) in
            if let error = error {
                AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
            }
            else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}

extension PatientEditProfileViewController : UITextFieldDelegate {
    
}



